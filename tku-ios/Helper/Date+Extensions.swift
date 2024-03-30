//
//  Date+Extensions.swift
//  tku-ios
//
//  Created by bochain on 3/30/24.
//

import SwiftUI

extension Date {
    func format(_ format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}
