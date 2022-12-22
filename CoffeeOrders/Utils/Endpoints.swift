//
//  Endpoints.swift
//  CoffeeOrders
//
//  Created by Alejandro Ignacio Aliaga Martinez on 22/12/22.
//

import Foundation

enum Endpoints {
    case order(Int)
    case allOrders
    case placeOrder
    case clearOrders
    case deleteOrder(Int)
    case updateOrder(Int)
    
    var path: String {
        switch self {
        case .order(let id):
            return "/test/orders/\(id)"
        case .allOrders:
            return "/test/orders"
        case .placeOrder:
            return "/test/new-order"
        case .clearOrders:
            return "/test/clear-orders"
        case .deleteOrder(let id):
            return "/test/orders/\(id)"
        case .updateOrder(let id):
            return "/test/orders/\(id)"
        }
    }
}
