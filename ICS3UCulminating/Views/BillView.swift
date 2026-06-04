//
//  BillView.swift
//  ICS3UCulminating
//

import SwiftUI

struct BillView: View {
    
    // MARK: - Stored properties
    var viewModel: BillViewModel
    
    @State private var showingAddSheet: Bool = false
    @State private var billToEdit: Bill? = nil
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            List {
                Section("All Bills") {
                    ForEach(viewModel.bills) { bill in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(bill.name)
                                    .font(.headline)
                                Text(bill.category)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text(bill.amount.formatted(.currency(code: "USD")))
                                    .foregroundStyle(bill.isOverdue ? .red : .primary)
                                    .font(.body)
                                    .bold()
                                
                                Text("Due: \(bill.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                    .font(.caption2)
                                    .foregroundStyle(bill.isOverdue ? .red : .secondary)
                            }
                            
                            Image(systemName: bill.isPaid ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(bill.isPaid ? .green : .secondary)
                                .padding(.leading, 8)
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            billToEdit = bill
                        }
                    }
                    .onDelete(perform: deleteBills)
                }
            }
            .navigationTitle("Bill")
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
                AddBillView(viewModel: viewModel)
            }
            .sheet(item: $billToEdit) { bill in
                EditBillView(viewModel: viewModel, bill: bill)
            }
        }
    }
    
    // MARK: - Functions
    
    func deleteBills(at offsets: IndexSet) {
        viewModel.removeBill(at: offsets)
    }
}

struct AddBillView: View {
    
    // MARK: - Stored properties
    var viewModel: BillViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var amountText: String = ""
    @State private var dueDate: Date = Date()
    @State private var isPaid: Bool = false
    @State private var category: String = ""
    @State private var notes: String = ""
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Form {
                Section("Bill Details") {
                    LabeledContent("Name") {
                        TextField("e.g. Rent", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Amount") {
                        TextField("0.00", text: $amountText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Category") {
                        TextField("e.g. Utilities", text: $category)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section("Status") {
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    
                    Toggle("Is Paid", isOn: $isPaid)
                }
                
                Section("Additional Info") {
                    LabeledContent("Notes") {
                        TextField("Optional", text: $notes)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Add Bill")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveBill()
                        dismiss()
                    }
                    .disabled(name.isEmpty)
                }
            }
        }
    }
    
    // MARK: - Functions
    
    func saveBill() {
        let amount: Double = Double(amountText) ?? 0.0
        let billNotes: String? = notes.isEmpty ? nil : notes
        
        viewModel.addBill(
            name: name,
            amount: amount,
            dueDate: dueDate,
            isPaid: isPaid,
            category: category,
            notes: billNotes
        )
    }
}

struct EditBillView: View {
    
    // MARK: - Stored properties
    var viewModel: BillViewModel
    let bill: Bill
    
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String
    @State private var amountText: String
    @State private var dueDate: Date
    @State private var isPaid: Bool
    @State private var category: String
    @State private var notes: String
    
    // MARK: - Initializer
    init(viewModel: BillViewModel, bill: Bill) {
        self.viewModel = viewModel
        self.bill = bill
        
        _name = State(initialValue: bill.name)
        _amountText = State(initialValue: String(format: "%.2f", bill.amount))
        _dueDate = State(initialValue: bill.dueDate)
        _isPaid = State(initialValue: bill.isPaid)
        _category = State(initialValue: bill.category)
        _notes = State(initialValue: bill.notes ?? "")
    }
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            Form {
                Section("Bill Details") {
                    LabeledContent("Name") {
                        TextField("e.g. Rent", text: $name)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Amount") {
                        TextField("0.00", text: $amountText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    LabeledContent("Category") {
                        TextField("e.g. Utilities", text: $category)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section("Status") {
                    DatePicker("Due Date", selection: $dueDate, displayedComponents: .date)
                    
                    Toggle("Is Paid", isOn: $isPaid)
                }
                
                Section("Additional Info") {
                    LabeledContent("Notes") {
                        TextField("Optional", text: $notes)
                            .multilineTextAlignment(.trailing)
                    }
                }
            }
            .navigationTitle("Edit Bill")
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
        let amount: Double = Double(amountText) ?? 0.0
        let billNotes: String? = notes.isEmpty ? nil : notes
        
        viewModel.updateBill(
            bill,
            name: name,
            amount: amount,
            dueDate: dueDate,
            isPaid: isPaid,
            category: category,
            notes: billNotes
        )
    }
}

#Preview {
    BillView(viewModel: BillViewModel())
}
