//
//  CalendarViewModel.swift
//  ICS3UCulminating
//

import Foundation
import Observation
import SwiftUI

// @Observable: This allows SwiftUI to watch this class for changes. 
// When any property here changes, the views using this model will refresh automatically.
@Observable
class CalendarViewModel {
    
    // MARK: - Stored properties
    var events: [CalendarEvent]
    
    // MARK: - Initializer
    init(events: [CalendarEvent] = CalendarEvent.exampleData) {
        self.events = events
        sortEvents()
    }
    
    // MARK: - Functions
    
    private func sortEvents() {
        // A closure is a block of code we can pass around. 
        // Here, we tell the 'sort' method how to compare two events (lhs and rhs) 
        // to decide which one comes first based on their start dates.
        events.sort { lhs, rhs in
            return lhs.startDate < rhs.startDate
        }
    }
    
    func addEvent(title: String, location: String, startDate: Date, endDate: Date, notes: String?) {
        let newEvent = CalendarEvent(title: title, location: location, startDate: startDate, endDate: endDate, notes: notes)
        events.append(newEvent)
        sortEvents()
    }
    
    func removeEvent(at indexSet: IndexSet) {
        events.remove(atOffsets: indexSet)
    }
    
    func updateEvent(_ event: CalendarEvent, title: String, location: String, startDate: Date, endDate: Date, notes: String?) {
        // We use a for-in loop to look through every event in our list.
        for index in 0..<events.count {
            // If the ID of the event we are looking at matches the ID of the event we want to update...
            if events[index].id == event.id {
                // ...then we update all its information.
                events[index].title = title
                events[index].location = location
                events[index].startDate = startDate
                events[index].endDate = endDate
                events[index].notes = notes
                break // Stop the loop once we found and updated the event.
            }
        }
        sortEvents()
    }
    
    func getOngoingEvents() -> [CalendarEvent] {
        var ongoing: [CalendarEvent] = []
        // Instead of complex filters, we manually loop through each event.
        for event in events {
            // If the event is currently happening, we add it to our 'ongoing' list.
            if event.isOngoing {
                ongoing.append(event)
            }
        }
        return ongoing
    }
}
