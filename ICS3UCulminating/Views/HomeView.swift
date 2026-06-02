//
//  HomeView.swift
//  ICS3UCulminating
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "house.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)
                Text("Home Content Goes Here")
                    .font(.title2)
            }
            .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
