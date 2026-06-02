//
//  CalendarEvent.swift
//  ICS3UCulminating
//

import Foundation

// MODEL
struct CalendarEvent: Identifiable {
    
    // MARK: - Stored properties
    let id = UUID()
    var title: String
    var location: String
    var startDate: Date
    var endDate: Date
    var notes: String?
    
    // MARK: - Computed properties
    var isOngoing: Bool {
        let now = Date()
        return now >= startDate && now <= endDate
    }
    
    // MARK: - Example data
    static let exampleData: [CalendarEvent] = [
        CalendarEvent(title: "Study Session", location: "Library", startDate: Date().addingTimeInterval(-3600), endDate: Date().addingTimeInterval(3600), notes: "Math exam prep"),
        CalendarEvent(title: "House Meeting", location: "Kitchen", startDate: Date().addingTimeInterval(86400), endDate: Date().addingTimeInterval(86400 + 1800), notes: "Discuss chores"),
        CalendarEvent(title: "Grocery Run", location: "Supermarket", startDate: Date().addingTimeInterval(-86400 * 2), endDate: Date().addingTimeInterval(-86400 * 2 + 3600), notes: "Need eggs"),
        CalendarEvent(title: "Birthday Party", location: "Sarah's Place", startDate: Date().addingTimeInterval(86400 * 3), endDate: Date().addingTimeInterval(86400 * 3 + 10800), notes: "Bring a gift"),
        CalendarEvent(title: "Project Sync", location: "Zoom", startDate: Date().addingTimeInterval(1800), endDate: Date().addingTimeInterval(5400), notes: "Final review"),
        CalendarEvent(title: "Morning Yoga", location: "Park", startDate: Date().addingTimeInterval(86400 * 1), endDate: Date().addingTimeInterval(86400 * 1 + 3600), notes: nil)
    ]
}
