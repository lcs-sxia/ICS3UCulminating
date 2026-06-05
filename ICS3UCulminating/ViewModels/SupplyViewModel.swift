//
//  SupplyViewModel.swift
//  ICS3UCulminating
//

import Foundation
import Observation
import SwiftUI

// @Observable: This macro makes the class observable. 
// It tells SwiftUI to keep an eye on these variables and refresh the screen whenever they change.
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
        // We use a simple for-in loop to check every item in our list.
        for item in items {
            // If the item's quantity is below its threshold, we add it to our new list.
            if item.isLowStock {
                lowStock.append(item)
            }
        }
        return lowStock
    }
    
    func updateItem(_ item: SupplyItem, name: String, quantity: Int, lowStockThreshold: Int, lastPurchased: Date, notes: String?) {
        // We loop through the items using their index (position in the list).
        for index in 0..<items.count {
            // If we find an item with the same unique ID...
            if items[index].id == item.id {
                // ...we update its details with the new information provided.
                items[index].name = name
                items[index].quantity = quantity
                items[index].lowStockThreshold = lowStockThreshold
                items[index].lastPurchased = lastPurchased
                items[index].notes = notes
                break // Stop searching once we've found and updated the item.
            }
        }
    }
}
