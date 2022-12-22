//
//  Configuration.swift
//  CoffeeOrders
//
//  Created by Alejandro Ignacio Aliaga Martinez on 22/12/22.
//

import Foundation

struct Configuration {
    
    lazy var environment: AppEnvironment = {
        // Read value from environment variable
        guard let env = ProcessInfo.processInfo.environment["ENV"] else {
            return .dev
        }
        
        if env == "QA" {
            return .qa
        }
        
        return .dev
    }()
    
}
