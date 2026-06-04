//
//  HomeView.swift
//  ICS3UCulminating
//

import SwiftUI

struct HomeView: View {
    
    // MARK: - Stored properties
    var supplyViewModel: SupplyViewModel
    var billViewModel: BillViewModel
    var choreViewModel: ChoreViewModel
    var calendarViewModel: CalendarViewModel
    
    // MARK: - Computed properties
    var body: some View {
        NavigationStack {
            List {
                // MARK: - Cover Banner Section
                Section {
                    VStack(spacing: 12) {
                        Image(systemName: "house.circle.fill")
                            .font(.system(size: 60))
                            .foregroundStyle(.white)
                            .padding(.top, 20)
                        
                        Text("HomeHub")
                            .font(.system(size: 34, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                        
                        Text("Welcome home! Here is what needs your attention.")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 20)
                    }
                    .frame(maxWidth: .infinity)
                    .background {
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                
                // MARK: - Urgent Calendar Events
                let ongoingEvents: [CalendarEvent] = calendarViewModel.getOngoingEvents()
                if ongoingEvents.isEmpty == false {
                    Section("Ongoing Events") {
                        ForEach(ongoingEvents) { event in
                            HStack {
                                Image(systemName: "calendar.badge.clock")
                                    .foregroundStyle(.blue)
                                VStack(alignment: .leading) {
                                    Text(event.title)
                                        .font(.headline)
                                    Text(event.location)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
                
                // MARK: - Overdue Bills
                let overdueBills: [Bill] = getOverdueBills()
                if overdueBills.isEmpty == false {
                    Section("Overdue Bills") {
                        ForEach(overdueBills) { bill in
                            HStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundStyle(.red)
                                VStack(alignment: .leading) {
                                    Text(bill.name)
                                        .font(.headline)
                                    Text("Due: \(bill.dueDate.formatted(date: .abbreviated, time: .omitted))")
                                        .font(.caption)
                                        .foregroundStyle(.red)
                                }
                                Spacer()
                                Text(bill.amount.formatted(.currency(code: "USD")))
                                    .bold()
                            }
                        }
                    }
                }
                
                // MARK: - Urgent Chores
                let urgentChores: [Chore] = getUrgentChores()
                if urgentChores.isEmpty == false {
                    Section("Urgent Chores") {
                        ForEach(urgentChores) { chore in
                            HStack {
                                Image(systemName: "list.bullet.circle.fill")
                                    .foregroundStyle(.orange)
                                VStack(alignment: .leading) {
                                    Text(chore.title)
                                        .font(.headline)
                                    Text("Assigned to: \(chore.assignedTo)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
                
                // MARK: - Low Stock Supplies
                let lowStockItems: [SupplyItem] = supplyViewModel.getLowStockItems()
                if lowStockItems.isEmpty == false {
                    Section("Low Stock Supplies") {
                        ForEach(lowStockItems) { item in
                            HStack {
                                Image(systemName: "cart.fill.badge.minus")
                                    .foregroundStyle(.red)
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text("Quantity: \(item.quantity)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }
                
                // MARK: - Empty State
                if ongoingEvents.isEmpty && overdueBills.isEmpty && urgentChores.isEmpty && lowStockItems.isEmpty {
                    Section {
                        VStack(spacing: 8) {
                            Image(systemName: "checkmark.seal.fill")
                                .font(.title)
                                .foregroundStyle(.green)
                            Text("You're all caught up!")
                                .font(.headline)
                            Text("No urgent items need your attention right now.")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    }
                }
            }
            .navigationTitle("Home")
            .navigationBarHidden(true)
        }
    }
    
    // MARK: - Functions
    
    func getOverdueBills() -> [Bill] {
        var result: [Bill] = []
        for bill in billViewModel.bills {
            if bill.isOverdue {
                result.append(bill)
            }
        }
        return result
    }
    
    func getUrgentChores() -> [Chore] {
        var result: [Chore] = []
        for chore in choreViewModel.chores {
            if chore.isUrgent {
                result.append(chore)
            }
        }
        return result
    }
}

#Preview {
    HomeView(
        supplyViewModel: SupplyViewModel(),
        billViewModel: BillViewModel(),
        choreViewModel: ChoreViewModel(),
        calendarViewModel: CalendarViewModel()
    )
}
