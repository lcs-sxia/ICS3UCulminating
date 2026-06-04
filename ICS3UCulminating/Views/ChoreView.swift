//
//  ChoreView.swift
//  ICS3UCulminating
//

import SwiftUI

struct ChoreView: View {
    
    // MARK: - Stored properties
    var viewModel: ChoreViewModel
    
    @State private var showingAddSheet: Bool = false
    @State private var choreToEdit: Chore? = nil
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            List {
                Section("All Chores") {
                    ForEach(viewModel.chores) { chore in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(chore.title)
                                    .font(.headline)
                                Text("Assigned to: \(chore.assignedTo)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Diff: \(chore.difficulty)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                                
                                Text("Due: \(chore.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.caption2)
                                    .foregroundStyle(chore.isUrgent ? .red : .secondary)
                            }
                            
                            Image(systemName: chore.isCompleted ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(chore.isCompleted ? .green : .secondary)
                                .padding(.leading, 8)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            choreToEdit = chore
                        }
                    }
                    .onDelete(perform: deleteChores)
                }
            }
            .navigationTitle("Chore")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        showingAddSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddChoreView(viewModel: viewModel)
            }
            .sheet(item: $choreToEdit) { chore in
                EditChoreView(viewModel: viewModel, chore: chore)
            }
        }
    }
    
    // MARK: - Functions
    
    func deleteChores(at offsets: IndexSet) {
        viewModel.removeChore(at: offsets)
    }
}

struct AddChoreView: View {
    
    // MARK: - Stored properties
    var viewModel: ChoreViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var assignedTo: String = ""
    @State private var dueDate: Date = Date()
    @State private var isCompleted: Bool = false
    @State private var difficultyText: String = ""
    @State private var notes: String = ""
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Form {
                Section("Chore Details") {
                    LabeledContent("Title") {
                        TextField("e.g. Wash Dishes", text: $title)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Assigned To") {
                        TextField("Name", text: $assignedTo)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Difficulty (1-5)") {
                        TextField("1", text: $difficultyText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section("Status") {
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    
                    Toggle("Is Completed", isOn: $isCompleted)
                }
                
                Section("Additional Info") {
                    LabeledContent("Notes") {
                        TextField("Optional", text: $notes)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Add Chore")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveChore()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    // MARK: - Functions
    
    func saveChore() {
        let difficulty: Int = Int(difficultyText) ?? 1
        let choreNotes: String? = notes.isEmpty ? nil : notes
        
        viewModel.addChore(
            title: title,
            assignedTo: assignedTo,
            dueDate: dueDate,
            isCompleted: isCompleted,
            difficulty: difficulty,
            notes: choreNotes
        )
    }
}

struct EditChoreView: View {
    
    // MARK: - Stored properties
    var viewModel: ChoreViewModel
    let chore: Chore
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String
    @State private var assignedTo: String
    @State private var dueDate: Date
    @State private var isCompleted: Bool
    @State private var difficultyText: String
    @State private var notes: String
    
    // MARK: - Initializer
    init(viewModel: ChoreViewModel, chore: Chore) {
        self.viewModel = viewModel
        self.chore = chore
        
        _title = State(initialValue: chore.title)
        _assignedTo = State(initialValue: chore.assignedTo)
        _dueDate = State(initialValue: chore.dueDate)
        _isCompleted = State(initialValue: chore.isCompleted)
        _difficultyText = State(initialValue: "\(chore.difficulty)")
        _notes = State(initialValue: chore.notes ?? "")
    }
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Form {
                Section("Chore Details") {
                    LabeledContent("Title") {
                        TextField("e.g. Wash Dishes", text: $title)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Assigned To") {
                        TextField("Name", text: $assignedTo)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Difficulty (1-5)") {
                        TextField("1", text: $difficultyText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section("Status") {
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    
                    Toggle("Is Completed", isOn: $isCompleted)
                }
                
                Section("Additional Info") {
                    LabeledContent("Notes") {
                        TextField("Optional", text: $notes)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Edit Chore")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveChanges()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    // MARK: - Functions
    
    func saveChanges() {
        let difficulty: Int = Int(difficultyText) ?? 1
        let choreNotes: String? = notes.isEmpty ? nil : notes
        
        viewModel.updateChore(
            chore,
            title: title,
            assignedTo: assignedTo,
            dueDate: dueDate,
            isCompleted: isCompleted,
            difficulty: difficulty,
            notes: choreNotes
        )
    }
}

#Preview {
    ChoreView(viewModel: ChoreViewModel())
}
