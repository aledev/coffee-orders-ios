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
    private func populateOrders() async {
        do {
            try await model.populateOrders()
        } catch {
            debugPrint(error)
        }
    }
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            
            if model.isLoading {
                
                HStack(spacing: 10) {
                    
                    ProgressView() //: ProgressView
                    
                    Text("Loading Orders...")
                        .font(.body)
                    
                } //: HStack
                
            } else {
                
                List(model.orders) { order in
                    
                    OrderCellView(order: order)
                    
                } //: List
                
            } //: Else
            
        } //: VStack
        .task {
            await populateOrders()
        }
        
    } //: Body
    
}

// MARK: - Previews
struct CoffeeListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        CoffeeListView()
            .environmentObject(CoffeeModel(orderService: OrderService()))
        
    }
}
