//
//  OrderCellView.swift
//  HelloCoffee
//
//  Created by Alejandro Ignacio Aliaga Martinez on 20/12/22.
//

import SwiftUI

struct OrderCellView: View {
    // MARK: - Properties
    let order: Order
    
    // MARK: - Body
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading, spacing: 2) {
                
                Text(order.name)
                    .bold()
                    .accessibilityIdentifier("orderNameText")
                
                Text("\(order.coffeeName) (\(order.size.rawValue))")
                    .opacity(0.5)
                    .accessibilityIdentifier("coffeeNameAndSizeText")
                
            } //: VStack
            
            Spacer()
            
            Text(order.total as NSNumber, formatter: NumberFormatter.currency)
                .foregroundColor(.accentColor)
                .accessibilityIdentifier("coffeePriceText")
            
        } //: VStack
        .padding()
        
    } //: Body
    
}

// MARK: - Preview
struct OrderCellView_Previews: PreviewProvider {
    static var previews: some View {
        OrderCellView(
            order: Order(
                name: "Ale",
                coffeeName: "Flat White",
                total: 4.5,
                size: .large
            )
        )
    }
}
