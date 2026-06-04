//
//  BillViewModel.swift
//  ICS3UCulminating
//

import Foundation
import Observation
import SwiftUI

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
        for index in 0..<bills.count {
            if bills[index].id == bill.id {
                bills[index].isPaid.toggle()
                break
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
        for index in 0..<bills.count {
            if bills[index].id == bill.id {
                bills[index].name = name
                bills[index].amount = amount
                bills[index].dueDate = dueDate
                bills[index].isPaid = isPaid
                bills[index].category = category
                bills[index].notes = notes
                break
            }
        }
    }
}
