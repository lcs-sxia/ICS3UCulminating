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
    
    func addItem(name: String, category: String, quantity: Int, unit: String, expiryDate: Date?) {
        let newItem = SupplyItem(name: name, category: category, quantity: quantity, unit: unit, expiryDate: expiryDate)
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
    
    // Style-compliant function to get expiring soon items
    func getExpiringSoonItems() -> [SupplyItem] {
        var expiringSoon: [SupplyItem] = []
        for item in items {
            if let days = item.daysUntilExpiry, days >= 0 && days <= 3 {
                expiringSoon.append(item)
            }
        }
        return expiringSoon
    }
}
