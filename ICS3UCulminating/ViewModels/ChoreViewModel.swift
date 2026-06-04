//
//  ChoreViewModel.swift
//  ICS3UCulminating
//

import Foundation
import Observation
import SwiftUI

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
        for index in 0..<chores.count {
            if chores[index].id == chore.id {
                chores[index].isCompleted.toggle()
                break
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
        for index in 0..<chores.count {
            if chores[index].id == chore.id {
                chores[index].title = title
                chores[index].assignedTo = assignedTo
                chores[index].dueDate = dueDate
                chores[index].isCompleted = isCompleted
                chores[index].difficulty = difficulty
                chores[index].notes = notes
                break
            }
        }
    }
}
