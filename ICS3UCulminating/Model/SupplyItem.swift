//
//  SupplyItem.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/06/01.
//

import Foundation

// MODEL
struct SupplyItem: Identifiable {
    
    // MARK: - Stored properties
    let id = UUID()
    var name: String
    var category: String
    var quantity: Int
    var unit: String // e.g., "bags", "liters", "units"
    var expiryDate: Date?
    
    // MARK: - Computed properties
    var isLowStock: Bool {
        return quantity <= 1
    }
    
    var daysUntilExpiry: Int? {
        guard let expiryDate = expiryDate else { return nil }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: expiryDate)
        return components.day
    }
}

// Example data
let exampleSupplies = [
    SupplyItem(name: "Milk", category: "Dairy", quantity: 1, unit: "carton", expiryDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())),
    SupplyItem(name: "Eggs", category: "Dairy", quantity: 12, unit: "units", expiryDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())),
    SupplyItem(name: "Bread", category: "Bakery", quantity: 0, unit: "loaf", expiryDate: Calendar.current.date(byAdding: .day, value: -1, to: Date())),
    SupplyItem(name: "Apples", category: "Produce", quantity: 5, unit: "units", expiryDate: nil)
]
