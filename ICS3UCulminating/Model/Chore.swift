//
//  Chore.swift
//  ICS3UCulminating
//

import Foundation

// MODEL
struct Chore: Identifiable {
    
    // MARK: - Stored properties
    let id = UUID()
    var title: String
    var assignedTo: String
    var dueDate: Date
    var isCompleted: Bool
    var difficulty: Int // e.g., 1 to 5 points
    var notes: String?
    
    // MARK: - Computed properties
    var isUrgent: Bool {
        if isCompleted {
            return false
        }
        // Due within 2 days (172,800 seconds)
        let twoDaysInSeconds: TimeInterval = 172800
        let timeUntilDue = dueDate.timeIntervalSince(Date())
        return timeUntilDue > 0 && timeUntilDue <= twoDaysInSeconds
    }
    
    // MARK: - Example data
    static let exampleData: [Chore] = [
        Chore(title: "Take out the trash", assignedTo: "Steven", dueDate: Date().addingTimeInterval(3600), isCompleted: false, difficulty: 1, notes: "Recycling too"),
        Chore(title: "Vacuum living room", assignedTo: "Sarah", dueDate: Date().addingTimeInterval(86400), isCompleted: false, difficulty: 3, notes: nil),
        Chore(title: "Clean the bathroom", assignedTo: "John", dueDate: Date().addingTimeInterval(-3600), isCompleted: true, difficulty: 5, notes: "Used the new cleaner"),
        Chore(title: "Wash the dishes", assignedTo: "Steven", dueDate: Date().addingTimeInterval(86400 * 3), isCompleted: false, difficulty: 2, notes: "Don't forget the pots"),
        Chore(title: "Mow the lawn", assignedTo: "Sarah", dueDate: Date().addingTimeInterval(86400 * 1), isCompleted: false, difficulty: 4, notes: "Wait for it to dry"),
        Chore(title: "Water the plants", assignedTo: "John", dueDate: Date().addingTimeInterval(86400 * 5), isCompleted: false, difficulty: 1, notes: "Indoor and outdoor")
    ]
}
