//
//  SupplyViewModel.swift
//  ICS3UCulminating
//

import Foundation
import Observation
import SwiftUI

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
    
    func getLowStockItems() -> [SupplyItem] {
        var lowStock: [SupplyItem] = []
        for item in items {
            if item.isLowStock {
                lowStock.append(item)
            }
        }
        return lowStock
    }
    
    func updateItem(_ item: SupplyItem, name: String, quantity: Int, lowStockThreshold: Int, lastPurchased: Date, notes: String?) {
        for index in 0..<items.count {
            if items[index].id == item.id {
                items[index].name = name
                items[index].quantity = quantity
                items[index].lowStockThreshold = lowStockThreshold
                items[index].lastPurchased = lastPurchased
                items[index].notes = notes
                break
            }
        }
    }
}
