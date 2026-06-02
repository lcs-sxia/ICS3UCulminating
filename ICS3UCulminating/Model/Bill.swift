//
//  Bill.swift
//  ICS3UCulminating
//

import Foundation

// MODEL
struct Bill: Identifiable {
    
    // MARK: - Stored properties
    let id = UUID()
    var name: String
    var amount: Double
    var dueDate: Date
    var isPaid: Bool
    var category: String
    var notes: String?
    
    // MARK: - Computed properties
    var isOverdue: Bool {
        return !isPaid && Date() > dueDate
    }
    
    // MARK: - Example data
    static let exampleData: [Bill] = [
        Bill(name: "Monthly Rent", amount: 1200.00, dueDate: Date().addingTimeInterval(-86400 * 2), isPaid: true, category: "Housing", notes: "Paid via e-transfer"),
        Bill(name: "Electricity", amount: 85.40, dueDate: Date().addingTimeInterval(-86400 * 5), isPaid: false, category: "Utilities", notes: "Overdue - check balance"),
        Bill(name: "Internet", amount: 75.00, dueDate: Date().addingTimeInterval(86400 * 10), isPaid: false, category: "Utilities", notes: nil),
        Bill(name: "Netflix Subscription", amount: 19.99, dueDate: Date().addingTimeInterval(86400 * 1), isPaid: false, category: "Entertainment", notes: "Auto-pay tomorrow"),
        Bill(name: "Water Bill", amount: 45.20, dueDate: Date().addingTimeInterval(86400 * 15), isPaid: false, category: "Utilities", notes: nil),
        Bill(name: "Gym Membership", amount: 60.00, dueDate: Date().addingTimeInterval(-86400 * 20), isPaid: true, category: "Health", notes: "Monthly renewal")
    ]
}
