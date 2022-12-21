//
//  CoffeeListView.swift
//  HelloCoffee
//
//  Created by Alejandro Ignacio Aliaga Martinez on 20/12/22.
//

import SwiftUI

struct CoffeeListView: View {
    // MARK: - Properties
    @EnvironmentObject private var model: CoffeeModel
    
    private func deleteOrder(_ indexSet: IndexSet) {
        indexSet.forEach { index in
            let order = model.orders[index]
            guard let orderId = order.id else {
                return
            }
            
            Task {
                await model.deleteOrder(orderId)
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                if model.isLoading {
                    
                    HStack(spacing: 10) {
                        
                        ProgressView() //: ProgressView
                        
                        Text("Loading Orders...")
                            .font(.body)
                        
                    } //: HStack
                    
                } else {
                    
                    if model.orders.isEmpty {
                        
                        Text("No orders available!")
                            .font(.body)
                            .accessibilityIdentifier("noOrdersText")
                        
                    } else {
                        
                        List{
                            
                            ForEach(model.orders) { order in
                                
                                OrderCellView(order: order)
                                
                            } //: ForEach
                            .onDelete(perform: deleteOrder)
                            
                        } //: List
                        .accessibilityIdentifier("orderList")
                        .refreshable {
                            await model.refreshOrders()
                        }
                        
                    }
                    
                } //: Else
                
            } //: VStack
            .task {
                await model.populateOrders()
            }
            
        } //: NavigationView        
        
    } //: Body
    
}

// MARK: - Previews
struct CoffeeListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        var config = Configuration()
        
        CoffeeListView()
            .environmentObject(CoffeeModel(orderService: OrderService(baseURL: config.environment.baseURL)))
        
        
    }
}
