//
//  AddCoffeeView.swift
//  CoffeeOrders
//
//  Created by Alejandro Ignacio Aliaga Martinez on 21/12/22.
//

import SwiftUI

struct EditCoffeeView: View {
    // MARK: - Properties
    @EnvironmentObject private var coffeeModel: CoffeeModel
    @Environment(\.dismiss) private var dismiss
    
    var order: Order? = nil
    
    @State private var name: String = ""
    @State private var coffeeName: String = ""
    @State private var price: String = ""
    @State private var coffeeSize: CoffeeSize = .medium
    @State private var errors: AddCoffeeErrors = AddCoffeeErrors()
        
    var isValid: Bool {
        errors = AddCoffeeErrors()
        
        if name.isEmpty {
            errors.name = "Name cannot be empty!"
        }
        
        if coffeeName.isEmpty {
            errors.coffeeName = "Coffee name cannot be empty"
        }
        
        if price.isEmpty {
            errors.price = "Price cannot be empty"
        } else if !price.isNumeric {
            errors.price = "Price needs to be a number"
        } else if price.isLessThan(1) {
            errors.price = "Price needs to be more than 0"
        }
        
        return errors.fieldsAreEmpty
    }
    
    // MARK: - Functions
    private func editOrder() async {
        guard var order = order else {
            return
        }
        
        order.name = name
        order.coffeeName = coffeeName
        order.total = Double(price) ?? 0
        order.size = coffeeSize
                
        await coffeeModel.updateOrder(order)
        dismiss()
    }
    
    private func populateExistingOrder() {
        guard let order = order else {
            return
        }
        
        self.name = order.name
        self.coffeeName = order.coffeeName
        self.price = String(order.total)
        self.coffeeSize = order.size
    }
    
    // MARK: - Body
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                TextField("Name", text: $name)
                    .accessibilityIdentifier("name")
                
                Text(errors.name)
                    .font(.caption)
                    .foregroundColor(.red)
                    .visible(errors.name.isNotEmpty)
                
                TextField("Coffee Name", text: $coffeeName)
                    .accessibilityIdentifier("coffeeName")
                
                Text(errors.coffeeName)
                    .font(.caption)
                    .foregroundColor(.red)
                    .visible(errors.coffeeName.isNotEmpty)
                
                TextField("Price", text: $price)
                    .accessibilityIdentifier("price")
                
                Text(errors.price)
                    .font(.caption)
                    .foregroundColor(.red)
                    .visible(errors.price.isNotEmpty)
                
                Picker("Select size", selection: $coffeeSize) {
                    
                    ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
                        
                        Text(size.rawValue)
                            .tag(size)
                        
                    } //: ForEach
                    
                } //: Picker
                .pickerStyle(.segmented)
                
                Button("Edit Order") {
                    if isValid {
                        Task {
                            await editOrder()
                        }
                    }
                }
                .accessibilityIdentifier("submitEditOrderButton")
                .centerHorizontally()
                
            } //: Form
            .navigationTitle("Edit Order")
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                    } //: Button
                    
                } //: ToolbarItem
                
            } //: Toolbar
            
        } //: NavigationStack
        .onAppear {
            self.populateExistingOrder()
        }
        
    } //: Body
    
}

// MARK: - Preview
struct EditCoffeeView_Previews: PreviewProvider {
    
    static var previews: some View {
        var config = Configuration()
        let order = Order(
            name: "John Doe",
            coffeeName: "Cappuccino",
            total: 4.5,
            size: .large
        )
        
        EditCoffeeView(order: order)
            .environmentObject(
                CoffeeModel(
                    orderService: OrderService(
                        baseURL: config.environment.baseURL
                    )
                )
            )
        
    }
    
}
