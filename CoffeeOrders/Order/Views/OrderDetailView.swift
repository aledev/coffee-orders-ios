//
//  OrderDetailView.swift
//  CoffeeOrders
//
//  Created by Alejandro Ignacio Aliaga Martinez on 22/12/22.
//

import SwiftUI

struct OrderDetailView: View {
    // MARK: - Properties
    @EnvironmentObject private var coffeeModel: CoffeeModel
    @Environment(\.dismiss) private var dismiss
    @State private var isPresented: Bool = false
    @State private var showingDeleteAlert = false
    
    let orderId: Int

    // MARK: - Body
    var body: some View {
    
        VStack {
         
            if let order = coffeeModel.order {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        
                        Text("Client:")
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Text(order.name)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .accessibilityIdentifier("coffeeClientText")
                        
                    } //: HStack
                    
                    HStack {
                        
                        Text("Coffee:")
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Text(order.coffeeName)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("coffeeNameText")
                        
                        Text("(\(order.size.rawValue))")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .accessibilityIdentifier("coffeeSizeText")
                        
                    } //: HStack
                    
                    HStack {
                        
                        Text("Price: ")
                            .font(.body)
                            .foregroundColor(.primary)
                        
                        Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                            .font(.body)
                            .foregroundColor(.accentColor)
                            .accessibilityIdentifier("coffeePriceText")
                        
                    } //: HStack
                    
                    HStack {
                        
                        Spacer()
                        
                        Button("Edit Order") {
                            isPresented = true
                        }
                        .accessibilityIdentifier("editOrderButton")
                        
                        Spacer()
                        
                        Button("Delete Order", role: .destructive) {
                            showingDeleteAlert = true
                        } //: Button
                        .alert("Are you sure you want to delete this order?",
                               isPresented: $showingDeleteAlert) {
                            
                            Button("Delete", role: .destructive) {
                                Task {
                                    await coffeeModel.deleteOrder(orderId)
                                    showingDeleteAlert = false
                                    dismiss()
                                }
                            } //: Button
                            
                            Button("Cancel", role: .cancel) {
                                showingDeleteAlert = false
                            } //: Button
                            
                        } //: alert
                        .accessibilityIdentifier("deleteOrderButton")
                        
                        Spacer()
                        
                    } //: HStack
                    .padding(.top, 10)
                    
                } //: VStack
                .fullScreenCover(isPresented: $isPresented, onDismiss: {
                    Task {
                        // Refresh the updated data
                        await coffeeModel.orderById(orderId)
                    }
                }) {
                    // Open Edit View
                    EditCoffeeView(order: order)
                }
                
                Spacer()
                
            } else { // Order is nil!
                
                NoDataView(message: "The order detail is not available :(")
                    .padding()
                
            } //: else
            
        } //: VStack
        .padding()
        .task {
            await coffeeModel.orderById(orderId)
        }
        
    } //: Body
    
}

// MARK: - Preview
struct OrderDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
                
        let coffeeModel = ({ () -> CoffeeModel in
            var config = Configuration()
            let orderService = OrderService(baseURL: config.environment.baseURL)
            let model = CoffeeModel(orderService: orderService)
            
            let order = Order(
                id: 1,
                name: "Ale",
                coffeeName: "Flat White",
                total: 4.5,
                size: .large
            )
            
            model.order = order
            
            return model
        })
        
        // Theme: Light
        OrderDetailView(orderId: 1)
            .environmentObject(
                coffeeModel()
            )
            .preferredColorScheme(.light)
        
        // Theme: Dark
        OrderDetailView(orderId: 1)
            .environmentObject(
                coffeeModel()
            )
            .preferredColorScheme(.dark)
        
    }
    
}
