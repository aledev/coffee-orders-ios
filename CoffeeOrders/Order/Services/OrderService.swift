//
//  Webservice.swift
//  HelloCoffee
//
//  Created by Mohammad Azam on 9/2/22.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case decodingError
    case badUrl
}

class OrderService {
    
    func getOrders() async throws -> [Order] {
                
        guard let url = URL(string: Constants.getAllOrdersURL) else {
            throw NetworkError.badUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let orders = try? JSONDecoder().decode([Order].self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return orders
    }
    
}
