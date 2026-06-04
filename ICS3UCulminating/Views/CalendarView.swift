//
//  CalendarView.swift
//  ICS3UCulminating
//

import SwiftUI

struct CalendarView: View {
    
    // MARK: - Stored properties
    var viewModel: CalendarViewModel
    
    @State private var showingAddSheet: Bool = false
    @State private var eventToEdit: CalendarEvent? = nil
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            List {
                Section("All Events") {
                    ForEach(viewModel.events) { event in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(event.title)
                                    .font(.headline)
                                Text(event.location)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text(event.startDate.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundStyle(event.isOngoing ? .blue : .primary)
                                
                                if event.isOngoing {
                                    Text("Ongoing")
                                        .font(.caption2)
                                        .foregroundStyle(.blue)
                                        .bold()
                                }
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            eventToEdit = event
                        }
                    }
                    .onDelete(perform: deleteEvents)
                }
            }
            .navigationTitle("Calendar")
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
                AddEventView(viewModel: viewModel)
            }
            .sheet(item: $eventToEdit) { event in
                EditEventView(viewModel: viewModel, event: event)
            }
        }
    }
    
    // MARK: - Functions
    
    func deleteEvents(at offsets: IndexSet) {
        viewModel.removeEvent(at: offsets)
    }
}

struct AddEventView: View {
    
    // MARK: - Stored properties
    var viewModel: CalendarViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var location: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date().addingTimeInterval(3600)
    @State private var notes: String = ""
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Form {
                Section("Event Details") {
                    LabeledContent("Title") {
                        TextField("e.g. Study Session", text: $title)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Location") {
                        TextField("e.g. Library", text: $location)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section("Date and Time") {
                    DatePicker("Starts", selection: $startDate)
                    DatePicker("Ends", selection: $endDate)
                }
                
                Section("Additional Info") {
                    LabeledContent("Notes") {
                        TextField("Optional", text: $notes)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Add Event")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveEvent()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    // MARK: - Functions
    
    func saveEvent() {
        let eventNotes: String? = notes.isEmpty ? nil : notes
        
        viewModel.addEvent(
            title: title,
            location: location,
            startDate: startDate,
            endDate: endDate,
            notes: eventNotes
        )
    }
}

struct EditEventView: View {
    
    // MARK: - Stored properties
    var viewModel: CalendarViewModel
    let event: CalendarEvent
    
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String
    @State private var location: String
    @State private var startDate: Date
    @State private var endDate: Date
    @State private var notes: String
    
    // MARK: - Initializer
    init(viewModel: CalendarViewModel, event: CalendarEvent) {
        self.viewModel = viewModel
        self.event = event
        
        _title = State(initialValue: event.title)
        _location = State(initialValue: event.location)
        _startDate = State(initialValue: event.startDate)
        _endDate = State(initialValue: event.endDate)
        _notes = State(initialValue: event.notes ?? "")
    }
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Form {
                Section("Event Details") {
                    LabeledContent("Title") {
                        TextField("e.g. Study Session", text: $title)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Location") {
                        TextField("e.g. Library", text: $location)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section("Date and Time") {
                    DatePicker("Starts", selection: $startDate)
                    DatePicker("Ends", selection: $endDate)
                }
                
                Section("Additional Info") {
                    LabeledContent("Notes") {
                        TextField("Optional", text: $notes)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Edit Event")
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
        let eventNotes: String? = notes.isEmpty ? nil : notes
        
        viewModel.updateEvent(
            event,
            title: title,
            location: location,
            startDate: startDate,
            endDate: endDate,
            notes: eventNotes
        )
    }
}

#Preview {
    CalendarView(viewModel: CalendarViewModel())
}
