//
//  CoffeeModel.swift
//  HelloCoffee
//
//  Created by Alejandro Ignacio Aliaga Martinez on 20/12/22.
//

import Foundation

@MainActor
class CoffeeModel: ObservableObject {
    
    // MARK: - Properties
    let orderService: OrderService
    @Published private(set) var orders: [Order] = []
    @Published private(set) var order: Order? = nil
    @Published private(set) var isLoading = false
    
    // MARK: - Initializer
    init(orderService: OrderService) {
        self.orderService = orderService
    }
    
    // MARK: - Functions
    func orderById(_ id: Int) async {
        do {
            self.order = try await orderService.getOrder(id)
        } catch {
            debugPrint("Error while trying the order by id. Detail: \(error)")
        }
    }
    
    func populateOrders() async {
        self.isLoading = true
        
        do {
            self.orders = try await orderService.getOrders()
        } catch {
            self.orders = []
            debugPrint("Error: \(error)")
        }
       
        self.isLoading = false
    }
    
    func refreshOrders() async {
        do {
            self.orders = try await orderService.getOrders()
        } catch {
            self.orders = []
        }
    }
    
    func placeOrder(_ order: Order) async {
        self.isLoading = true
        
        do {
            let newOrder = try await orderService.placeOrder(order: order)
            orders.append(newOrder)
        } catch {
            debugPrint("Error: \(error)")
        }
        
        self.isLoading = false
    }
    
    func deleteOrder(_ orderId: Int) async {
        do {
            let deletedOrder = try await orderService.deleteOrder(orderId: orderId)
            orders = orders.filter { $0.id != deletedOrder.id }
        } catch {
            debugPrint("Error: \(error)")
        }
    }
    
    func updateOrder(_ order: Order) async {
        do {
            let updateOrder = try await orderService.updateOrder(order)
            guard let index = orders.firstIndex(where: { $0.id == updateOrder.id }) else {
                throw CoffeeOrderError.invalidOrderId
            }
            orders[index] = updateOrder
        } catch {
            debugPrint("Error: \(error)")
        }
    }
    
}
