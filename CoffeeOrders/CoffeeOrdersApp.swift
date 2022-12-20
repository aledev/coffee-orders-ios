//
//  HelloCoffeeApp.swift
//  HelloCoffee
//
//  Created by Alejandro Ignacio Aliaga Martinez on 20/12/22.
//

import SwiftUI

@main
struct CoffeeOrdersApp: App {
    // MARK: - Properties
    @StateObject private var coffeeModel: CoffeeModel
    
    // MARK: - Initializer
    init() {
        let orderService = OrderService()
        _coffeeModel = StateObject(wrappedValue: CoffeeModel(orderService: orderService))
    }
    
    // MARK: - Body
    var body: some Scene {
        
        WindowGroup {
        
            ContentView()
                .environmentObject(coffeeModel)
            
        }
        
    }
}
