//
//  AppEnvironment.swift
//  HelloCoffee
//
//  Created by Alejandro Ignacio Aliaga Martinez on 20/12/22.
//

import Foundation

enum Endpoints {
    case allOrders
    case placeOrder
    case clearOrders
    case deleteOrder(Int)
    
    var path: String {
        switch self {
        case .allOrders:
            return "/test/orders"
        case .placeOrder:
            return "/test/new-order"
        case .clearOrders:
            return "/test/clear-orders"
        case .deleteOrder(let id):
            return "/test/orders/\(id)"
        }
    }
}

enum AppEnvironment: String {
    case dev
    case qa
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "http://localhost:3000")!
        case .qa:
            return URL(string: "https://coffee-orders-backend.herokuapp.com")!
        }
    }
}

struct Configuration {
    
    lazy var environment: AppEnvironment = {
        // Read value from environment variable
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return .qa
        }
        
        if env == "QA" {
            return .qa
        }
        
        return .dev
    }()
    
}
