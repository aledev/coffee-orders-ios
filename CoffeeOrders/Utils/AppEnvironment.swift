//
//  AppEnvironment.swift
//  HelloCoffee
//
//  Created by Alejandro Ignacio Aliaga Martinez on 20/12/22.
//

import Foundation

enum AppEnvironment: String {
    case dev
    case qa
    
    var baseURL: URL {
        switch self {
        case .dev:
            return URL(string: "http://localhost:3000")!
        case .qa:
            return URL(string: "https://coffee-orders-api.com")!
        }
    }
}
