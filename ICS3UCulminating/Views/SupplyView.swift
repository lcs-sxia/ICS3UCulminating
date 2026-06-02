//
//  SupplyView.swift
//  ICS3UCulminating
//

import SwiftUI

struct SupplyView: View {
    
    // MARK: - Stored properties
    var viewModel: SupplyViewModel
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            List {
                Section("Smart Suggestions") {
                    let lowStock = viewModel.getLowStockItems()
                    if lowStock.isEmpty == false {
                        ForEach(lowStock) { item in
                            HStack {
                                Image(systemName: "cart.badge.minus")
                                    .foregroundStyle(.red)
                                Text("\(item.name) is low on stock!")
                            }
                        }
                    } else {
                        Text("All clear! No urgent items.")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
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
                    }
                    .onDelete { indexSet in
                        viewModel.removeItem(at: indexSet)
                    }
                }
            }
            .navigationTitle("Supply")
        }
    }
}

#Preview {
    SupplyView(viewModel: SupplyViewModel())
}
