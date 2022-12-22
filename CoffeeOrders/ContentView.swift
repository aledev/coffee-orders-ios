//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Alejandro Ignacio Aliaga Martinez on 20/12/22.
//

import SwiftUI

struct ContentView: View {
    // MARK: - Properties
    @State private var isPresented: Bool = false
    
    // MARK: - Body
    var body: some View {
        
        NavigationStack {
         
            CoffeeListView()
                .navigationTitle("Coffee Orders")
                .navigationBarTitleDisplayMode(.large)
                .fullScreenCover(isPresented: $isPresented) {                    
                    AddCoffeeView()
                }
                .toolbar {
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        
                        Button("Add New Order") {
                            isPresented = true
                        }
                        .accessibilityIdentifier("addNewOrderButton")
                        
                    } //: ToolbarItem
                    
                } //: Toolbar
                .ignoresSafeArea(.all)
            
        } //: NavigationView        
        
    } //: Body
    
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        var config = Configuration()
        
        ContentView()
            .environmentObject(
                CoffeeModel(
                    orderService: OrderService(
                        baseURL: config.environment.baseURL
                    )
                )
            )
        
    }
    
}
