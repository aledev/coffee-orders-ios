//
//  Webservice.swift
//  HelloCoffee
//
//  Created by Alejandro Ignacio Aliaga Martinez on 20/12/22.
//

import Foundation

class OrderService {
    
    private var baseURL: URL
    
    init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    func placeOrder(order: Order) async throws -> Order {
        guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }
        
        guard let jsonBody = try? JSONEncoder().encode(order) else {
            throw NetworkError.encodingError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let orderResponse = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return orderResponse
    }
    
    func getOrders() async throws -> [Order] {
        guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL) else {
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
    
    func getOrder(_ orderId: Int) async throws -> Order {
        guard let url = URL(string: Endpoints.order(orderId).path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let order = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return order
    }
    
    func clearOrders() async throws -> Bool {
        guard let url = URL(string: Endpoints.clearOrders.path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }
        
        let (_, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 304 else {
            return false
        }
        
        return true
    }
    
    func deleteOrder(orderId: Int) async throws -> Order {
        guard let url = URL(string: Endpoints.deleteOrder(orderId).path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let deletedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        debugPrint("Deleted Order: \(deletedOrder)")
        
        return deletedOrder
    }
    
    func updateOrder(_ order: Order) async throws -> Order {
        guard let orderId = order.id else {
            throw NetworkError.badUrl
        }
        
        guard let url = URL(string: Endpoints.updateOrder(orderId).path, relativeTo: baseURL) else {
            throw NetworkError.badUrl
        }
        
        guard let jsonBody = try? JSONEncoder().encode(order) else {
            throw NetworkError.encodingError
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.httpBody = jsonBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw NetworkError.badRequest
        }
        
        guard let updatedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
            throw NetworkError.decodingError
        }
        
        return updatedOrder
    }
    
}
