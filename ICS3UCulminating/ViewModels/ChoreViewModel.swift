//
//  ChoreViewModel.swift
//  ICS3UCulminating
//

import Foundation
import Observation
import SwiftUI

// @Observable: This tells SwiftUI that it should watch this class for any changes. 
// If a chore is added or updated, the UI will refresh automatically to show the change.
@Observable
class ChoreViewModel {
    
    // MARK: - Stored properties
    var chores: [Chore]
    
    // MARK: - Initializer
    init(chores: [Chore] = Chore.exampleData) {
        self.chores = chores
    }
    
    // MARK: - Functions
    
    func toggleCompletion(for chore: Chore) {
        // We use a for-in loop to check every chore in our list one by one.
        for index in 0..<chores.count {
            // If the chore's ID matches the one we want to toggle...
            if chores[index].id == chore.id {
                // ...we switch its completion status (true to false, or false to true).
                chores[index].isCompleted.toggle()
                break // Stop searching once we've found and updated the chore.
            }
        }
    }
    
    func addChore(title: String, assignedTo: String, dueDate: Date, isCompleted: Bool, difficulty: Int, notes: String?) {
        let newChore = Chore(title: title, assignedTo: assignedTo, dueDate: dueDate, isCompleted: isCompleted, difficulty: difficulty, notes: notes)
        chores.append(newChore)
    }
    
    func removeChore(at indexSet: IndexSet) {
        chores.remove(atOffsets: indexSet)
    }
    
    func updateChore(_ chore: Chore, title: String, assignedTo: String, dueDate: Date, isCompleted: Bool, difficulty: Int, notes: String?) {
        // We loop through the list of chores using their index position.
        for index in 0..<chores.count {
            // If we find a chore that matches the ID of the chore we want to update...
            if chores[index].id == chore.id {
                // ...we update its details with the new information.
                chores[index].title = title
                chores[index].assignedTo = assignedTo
                chores[index].dueDate = dueDate
                chores[index].isCompleted = isCompleted
                chores[index].difficulty = difficulty
                chores[index].notes = notes
                break // End the loop early since we found our item.
            }
        }
    }
}
