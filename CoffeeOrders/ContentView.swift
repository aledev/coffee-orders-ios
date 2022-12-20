//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Mohammad Azam on 9/2/22.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Body
    var body: some View {
        
        NavigationView {
         
            CoffeeListView()
                .navigationTitle("Coffee Orders")
                .navigationBarTitleDisplayMode(.inline)
            
        } //: NavigationView
        
    } //: Body
    
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .environmentObject(CoffeeModel(orderService: OrderService()))
    }
    
}
