//
//  AddCoffeeView.swift
//  CoffeeOrders
//
//  Created by Alejandro Ignacio Aliaga Martinez on 21/12/22.
//

import SwiftUI

struct AddCoffeeView: View {
    // MARK: - Properties
    @EnvironmentObject private var coffeeModel: CoffeeModel
    @Environment(\.dismiss) private var dismiss
    
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
    private func placeOrder() async {
        let order = Order(
            name: name,
            coffeeName: coffeeName,
            total: Double(price) ?? 0,
            size: coffeeSize
        )
        
        await coffeeModel.placeOrder(order)
        dismiss()
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
                
                Button("Place Order") {
                    if isValid {
                        Task {
                            await placeOrder()
                        }
                    }
                }
                .accessibilityIdentifier("placeOrderButton")
                .centerHorizontally()
                
            } //: Form
            .navigationTitle("Add Coffee")
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
        
    } //: Body
    
}

// MARK: - Preview
struct AddCoffeeView_Previews: PreviewProvider {
    
    static var previews: some View {
        var config = Configuration()
        
        AddCoffeeView()
            .environmentObject(
                CoffeeModel(
                    orderService: OrderService(
                        baseURL: config.environment.baseURL
                    )
                )
            )
        
    }
    
}
