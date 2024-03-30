//
//  View+Extensions.swift
//  tku-ios
//
//  Created by bochain on 3/30/24.
//

//
//  View+Extensions.swift
//  Expense Tracker
//
//  Created by bochain on 1/25/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
