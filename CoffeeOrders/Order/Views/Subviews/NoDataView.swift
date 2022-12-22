//
//  NoDataView.swift
//  CoffeeOrders
//
//  Created by Alejandro Ignacio Aliaga Martinez on 22/12/22.
//

import SwiftUI

struct NoDataView: View {
    // MARK: - Properties
    let message: String
    
    // MARK: - Body
    var body: some View {
        
        VStack(spacing: 20) {
            
            Image(systemName: "exclamationmark.circle")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(message)
                .font(.title3)
                .foregroundColor(.secondary)
                .accessibilityIdentifier("noOrdersText")
            
        } //: VStack
        .accessibilityIdentifier("noDataView")
        
    } //: Body
    
}

// MARK: - Preview
struct NoDataView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        // Theme: Light
        NoDataView(message: "No Data Available :(")
            .preferredColorScheme(.light)
        
        // Theme: Dark
        NoDataView(message: "No Data Available :(")
            .preferredColorScheme(.dark)
        
    }
    
}
