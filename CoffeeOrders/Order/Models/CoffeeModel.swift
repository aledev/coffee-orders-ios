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
    @Published private(set) var isLoading = false
    
    // MARK: - Initializer
    init(orderService: OrderService) {
        self.orderService = orderService
    }
    
    // MARK: - Functions
    func populateOrders() async throws {
        self.isLoading = true
        
        do {
            self.orders = try await orderService.getOrders()
        } catch {
            throw error
        }
       
        self.isLoading = false
    }
    
}
