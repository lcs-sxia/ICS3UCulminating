//
//  MainTabView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: - Stored properties
    
    // @State: This is used for data that belongs to the view. 
    // Even if the view refreshes, SwiftUI keeps this data safe.
    @State private var supplyViewModel = SupplyViewModel()
    @State private var billViewModel = BillViewModel()
    @State private var choreViewModel = ChoreViewModel()
    @State private var calendarViewModel = CalendarViewModel()
    
    // MARK: - Computed properties
    
    // The 'body' is a computed property. It calculates how the screen should look 
    // every time SwiftUI decides it needs to be updated.
    var body: some View {
        // TabView: Creates a bar at the bottom of the screen to switch between different views.
        TabView {
            // Home Tab
            HomeView(
                supplyViewModel: supplyViewModel,
                billViewModel: billViewModel,
                choreViewModel: choreViewModel,
                calendarViewModel: calendarViewModel
            )
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            // Supply Tab
            SupplyView(viewModel: supplyViewModel)
                .tabItem {
                    Label("Supply", systemImage: "cart")
                }
            
            // Bill Tab
            BillView(viewModel: billViewModel)
                .tabItem {
                    Label("Bill", systemImage: "dollarsign")
                }
            
            // Chore Tab
            ChoreView(viewModel: choreViewModel)
                .tabItem {
                    Label("Chore", systemImage: "checklist")
                }
            
            // Calendar Tab
            CalendarView(viewModel: calendarViewModel)
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    MainTabView()
}
