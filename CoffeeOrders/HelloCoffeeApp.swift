//
//  HelloCoffeeApp.swift
//  HelloCoffee
//
//  Created by Mohammad Azam on 9/2/22.
//

import SwiftUI

@main
struct HelloCoffeeApp: App {
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
