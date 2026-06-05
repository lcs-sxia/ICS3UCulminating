//
//  BillViewModel.swift
//  ICS3UCulminating
//

import Foundation
import Observation
import SwiftUI

// @Observable: This tells SwiftUI that it should watch this class for any changes. 
// If a bill is added or updated, any screen showing the bills will update automatically.
@Observable
class BillViewModel {
    
    // MARK: - Stored properties
    var bills: [Bill]
    
    // MARK: - Initializer
    init(bills: [Bill] = Bill.exampleData) {
        self.bills = bills
    }
    
    // MARK: - Functions
    
    func togglePaidStatus(for bill: Bill) {
        // We use a for-in loop to search through our list of bills.
        for index in 0..<bills.count {
            // If the bill's ID matches the one we want to change...
            if bills[index].id == bill.id {
                // ...we flip its 'isPaid' status from true to false, or vice versa.
                bills[index].isPaid.toggle()
                break // We found it, so we can stop the loop.
            }
        }
    }
    
    func addBill(name: String, amount: Double, dueDate: Date, isPaid: Bool, category: String, notes: String?) {
        let newBill = Bill(name: name, amount: amount, dueDate: dueDate, isPaid: isPaid, category: category, notes: notes)
        bills.append(newBill)
    }
    
    func removeBill(at indexSet: IndexSet) {
        bills.remove(atOffsets: indexSet)
    }
    
    func updateBill(_ bill: Bill, name: String, amount: Double, dueDate: Date, isPaid: Bool, category: String, notes: String?) {
        // We look through the list of bills using their index (their order in the list).
        for index in 0..<bills.count {
            // Once we find a bill with a matching ID...
            if bills[index].id == bill.id {
                // ...we update all of its stored information with the new values.
                bills[index].name = name
                bills[index].amount = amount
                bills[index].dueDate = dueDate
                bills[index].isPaid = isPaid
                bills[index].category = category
                bills[index].notes = notes
                break // Exit the loop after the update is done.
            }
        }
    }
}
