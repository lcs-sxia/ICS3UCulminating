//
//  MainTabView.swift
//  ICS3UCulminating
//
//  Created by Gemini CLI on 2026/6/1.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: - Stored properties
    @State private var supplyViewModel = SupplyViewModel()
    
    // MARK: - Computed properties
    var body: some View {
        TabView {
            // Home Tab
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            // Supply Tab
            SupplyView(viewModel: supplyViewModel)
                .tabItem {
                    Label("Supply", systemImage: "cart")
                }
            
            // Bill Tab
            BillView()
                .tabItem {
                    Label("Bill", systemImage: "banknote")
                }
            
            // Chore Tab
            ChoreView()
                .tabItem {
                    Label("Chore", systemImage: "list.clipboard")
                }
            
            // Calendar Tab
            CalendarView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    MainTabView()
}
