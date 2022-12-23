//
//  AddCoffeeErrors.swift
//  CoffeeOrders
//
//  Created by Alejandro Ignacio Aliaga Martinez on 23/12/22.
//

import Foundation

struct AddCoffeeErrors {
    var name: String = ""
    var coffeeName: String = ""
    var price: String = ""
    
    var fieldsAreEmpty: Bool {
        return name.isEmpty &&
        coffeeName.isEmpty &&
        price.isEmpty
    }
}
