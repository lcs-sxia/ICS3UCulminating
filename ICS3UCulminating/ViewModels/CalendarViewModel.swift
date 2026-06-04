//
//  CalendarViewModel.swift
//  ICS3UCulminating
//

import Foundation
import Observation
import SwiftUI

@Observable
class CalendarViewModel {
    
    // MARK: - Stored properties
    var events: [CalendarEvent]
    
    // MARK: - Initializer
    init(events: [CalendarEvent] = CalendarEvent.exampleData) {
        self.events = events
    }
    
    // MARK: - Functions
    
    func addEvent(title: String, location: String, startDate: Date, endDate: Date, notes: String?) {
        let newEvent = CalendarEvent(title: title, location: location, startDate: startDate, endDate: endDate, notes: notes)
        events.append(newEvent)
    }
    
    func removeEvent(at indexSet: IndexSet) {
        events.remove(atOffsets: indexSet)
    }
    
    func getOngoingEvents() -> [CalendarEvent] {
        var ongoing: [CalendarEvent] = []
        for event in events {
            if event.isOngoing {
                ongoing.append(event)
            }
        }
        return ongoing
    }
}
