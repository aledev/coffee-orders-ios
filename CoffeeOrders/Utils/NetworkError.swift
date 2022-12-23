//
//  NetworkError.swift
//  CoffeeOrders
//
//  Created by Alejandro Ignacio Aliaga Martinez on 23/12/22.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case encodingError
    case decodingError
    case badUrl
}
