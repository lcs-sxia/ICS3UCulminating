//
//  SupplyItem.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/06/01.
//

import Foundation
import Observation

// MODEL
struct SupplyItem: Identifiable {
    
    // MARK: - Stored properties
    let id = UUID()
    var name: String // e.g., "apple", "milk", "bread"
    var quantity: Int // current amount
    var lowStockThreshold: Int // the values will display insufficient
    var lastPurchased: Date = Date()
    var notes: String? // remark, not essential
    
    // MARK: - Computed properties
    var isLowStock: Bool {
        return quantity <= lowStockThreshold
    }
}

// Example data
let exampleSupplies: [SupplyItem] = [
    SupplyItem(name: "Toilet Paper", quantity: 2, lowStockThreshold: 4, lastPurchased: Date().addingTimeInterval(-86400 * 5), notes: "4-pack"),
    SupplyItem(name: "Milk", quantity: 1, lowStockThreshold: 2, lastPurchased: Date().addingTimeInterval(-86400 * 2), notes: "2% Organic"),
    SupplyItem(name: "Dish Soap", quantity: 3, lowStockThreshold: 1, lastPurchased: Date().addingTimeInterval(-86400 * 10), notes: nil),
    SupplyItem(name: "Trash Bags", quantity: 15, lowStockThreshold: 5, lastPurchased: Date().addingTimeInterval(-86400 * 20), notes: "Large size"),
    SupplyItem(name: "Hand Soap", quantity: 0, lowStockThreshold: 2, lastPurchased: Date().addingTimeInterval(-86400 * 15), notes: "Refill needed"),
    SupplyItem(name: "Paper Towels", quantity: 6, lowStockThreshold: 2, lastPurchased: Date().addingTimeInterval(-86400 * 7), notes: nil),
    SupplyItem(name: "Coffee", quantity: 1, lowStockThreshold: 2, lastPurchased: Date().addingTimeInterval(-86400 * 1), notes: "Whole bean")
]
