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
    
    // MARK: - Functions
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
                                                
                        ScrollView {
                         
                            NoDataView(message: "No orders available!")
                                .padding()
                            
                        } //: ScrollView
                        .refreshable {
                            await model.refreshOrders()
                        }
                        
                    } else {
                        
                        List{
                            
                            ForEach(model.orders) { order in
                                
                                NavigationLink(value: order.id) {
                                    
                                    OrderCellView(order: order)
                                    
                                } //: NavigationLink
                                
                            } //: ForEach
                            .onDelete(perform: deleteOrder)
                            
                        } //: List
                        .listStyle(.inset)
                        .accessibilityIdentifier("orderList")
                        .refreshable {
                            await model.refreshOrders()
                        }
                        
                    } //: Else
                    
                } //: Else
                
            } //: VStack
            .navigationDestination(for: Int.self, destination: { orderId in
                
                OrderDetailView(orderId: orderId)
                
            })
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
            .environmentObject(
                CoffeeModel(
                    orderService: OrderService(
                        baseURL: config.environment.baseURL
                    )
                )
            )
        
    }
}
