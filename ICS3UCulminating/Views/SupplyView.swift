//
//  SupplyView.swift
//  ICS3UCulminating
//

import SwiftUI

struct SupplyView: View {
    
    // MARK: - Stored properties
    var viewModel: SupplyViewModel
    
    @State private var showingAddSheet: Bool = false
    @State private var itemToEdit: SupplyItem? = nil
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            List {
                // Section for urgent items
                Section("Smart Suggestions") {
                    let lowStockItems: [SupplyItem] = viewModel.getLowStockItems()
                    
                    if lowStockItems.isEmpty == false {
                        ForEach(lowStockItems) { item in
                            HStack {
                                Image(systemName: "cart.badge.minus")
                                    .foregroundStyle(.red)
                                Text("\(item.name) is low on stock!")
                            }
                            .onTapGesture {
                                itemToEdit = item
                            }
                        }
                    } else {
                        Text("All clear! No urgent items.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                // Section for all items
                Section("All Supplies") {
                    ForEach(viewModel.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                if let notes = item.notes {
                                    Text(notes)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("\(item.quantity)")
                                    .foregroundStyle(item.isLowStock ? .red : .primary)
                                    .font(.title3)
                                    .bold()
                                
                                Text("Last: \(item.lastPurchased.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            itemToEdit = item
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Supply")
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
                AddSupplyView(viewModel: viewModel)
            }
            .sheet(item: $itemToEdit) { item in
                EditSupplyView(viewModel: viewModel, item: item)
            }
        }
    }
    
    // MARK: - Functions
    
    func deleteItems(at offsets: IndexSet) {
        viewModel.removeItem(at: offsets)
    }
}

struct AddSupplyView: View {
    
    // MARK: - Stored properties
    var viewModel: SupplyViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var quantityText: String = ""
    @State private var thresholdText: String = ""
    @State private var lastPurchased: Date = Date()
    @State private var notes: String = ""
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Form {
                Section("Item Details") {
                    LabeledContent("Name") {
                        TextField("e.g. Milk", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Current Quantity") {
                        TextField("0", text: $quantityText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Low Stock Threshold") {
                        TextField("0", text: $thresholdText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section("Additional Info") {
                    DatePicker("Last Purchased", selection: $lastPurchased, displayedComponents: .date)
                    
                    LabeledContent("Notes") {
                        TextField("Optional", text: $notes)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Add Supply")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveItem()
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    // MARK: - Functions
    
    func saveItem() {
        let quantity: Int = Int(quantityText) ?? 0
        let threshold: Int = Int(thresholdText) ?? 0
        let itemNotes: String? = notes.isEmpty ? nil : notes
        
        viewModel.addItem(
            name: name,
            quantity: quantity,
            lowStockThreshold: threshold,
            lastPurchased: lastPurchased,
            notes: itemNotes
        )
    }
}

struct EditSupplyView: View {
    
    // MARK: - Stored properties
    var viewModel: SupplyViewModel
    let item: SupplyItem
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String
    @State private var quantityText: String
    @State private var thresholdText: String
    @State private var lastPurchased: Date
    @State private var notes: String
    
    // MARK: - Initializer
    init(viewModel: SupplyViewModel, item: SupplyItem) {
        self.viewModel = viewModel
        self.item = item
        
        _name = State(initialValue: item.name)
        _quantityText = State(initialValue: "\(item.quantity)")
        _thresholdText = State(initialValue: "\(item.lowStockThreshold)")
        _lastPurchased = State(initialValue: item.lastPurchased)
        _notes = State(initialValue: item.notes ?? "")
    }
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Form {
                Section("Item Details") {
                    LabeledContent("Name") {
                        TextField("e.g. Milk", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Current Quantity") {
                        TextField("0", text: $quantityText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Low Stock Threshold") {
                        TextField("0", text: $thresholdText)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section("Additional Info") {
                    DatePicker("Last Purchased", selection: $lastPurchased, displayedComponents: .date)
                    
                    LabeledContent("Notes") {
                        TextField("Optional", text: $notes)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Edit Supply")
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
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    // MARK: - Functions
    
    func saveChanges() {
        let quantity: Int = Int(quantityText) ?? 0
        let threshold: Int = Int(thresholdText) ?? 0
        let itemNotes: String? = notes.isEmpty ? nil : notes
        
        viewModel.updateItem(
            item,
            name: name,
            quantity: quantity,
            lowStockThreshold: threshold,
            lastPurchased: lastPurchased,
            notes: itemNotes
        )
    }
}

#Preview {
    SupplyView(viewModel: SupplyViewModel())
}
