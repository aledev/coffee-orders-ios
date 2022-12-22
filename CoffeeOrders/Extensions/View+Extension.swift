//
//  View+Extension.swift
//  CoffeeOrders
//
//  Created by Alejandro Ignacio Aliaga Martinez on 21/12/22.
//

import Foundation
import SwiftUI

extension View {
    
    func centerHorizontally() -> some View {
        HStack {
            Spacer()
            self
            Spacer()
        }
    }
    
    @ViewBuilder
    func visible(_ value: Bool) -> some View {
        if value {
            self
        } else {
            EmptyView()
        }
    }
    
}
