//
//  SupplyViewModel.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/06/01.
//

import Foundation
import Observation
import SwiftUI

// VIEW MODEL
@Observable
class SupplyViewModel {
    
    // MARK: - Stored properties
    var items: [SupplyItem]
    
    // MARK: - Initializer
    init(items: [SupplyItem] = exampleSupplies) {
        self.items = items
    }
    
    // MARK: - Functions
    
    func addItem(name: String, quantity: Int, lowStockThreshold: Int, lastPurchased: Date = Date(), notes: String? = nil) {
        let newItem = SupplyItem(name: name, quantity: quantity, lowStockThreshold: lowStockThreshold, lastPurchased: lastPurchased, notes: notes)
        items.append(newItem)
    }
    
    func removeItem(at indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    // Style-compliant function to get low stock items (avoiding .filter)
    func getLowStockItems() -> [SupplyItem] {
        var lowStock: [SupplyItem] = []
        for item in items {
            if item.isLowStock {
                lowStock.append(item)
            }
        }
        return lowStock
    }
}
