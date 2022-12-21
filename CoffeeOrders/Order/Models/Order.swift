//
//  Order.swift
//  HelloCoffee
//
//  Created by Alejandro Ignacio Aliaga Martinez on 20/12/22.
//

import Foundation

struct Order: Codable, Identifiable, Hashable {
    
    var id: Int?
    var name: String
    var coffeeName: String
    var total: Double
    var size: CoffeeSize
    
}
