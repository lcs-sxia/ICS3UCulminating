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
                    let expiring = viewModel.getExpiringSoonItems()
                    if expiring.isEmpty == false {
                        ForEach(expiring) { item in
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundStyle(.orange)
                                Text("\(item.name) is expiring soon!")
                            }
                        }
                    }
                    
                    let lowStock = viewModel.getLowStockItems()
                    if lowStock.isEmpty == false {
                        ForEach(lowStock) { item in
                            HStack {
                                Image(systemName: "cart.badge.minus")
                                    .foregroundStyle(.red)
                                Text("\(item.name) is low on stock!")
                            }
                        }
                    }
                    
                    if expiring.isEmpty && lowStock.isEmpty {
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
                                Text(item.category)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            
                            Spacer()
                            
                            Text("\(item.quantity) \(item.unit)")
                                .foregroundStyle(item.isLowStock ? .red : .primary)
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
