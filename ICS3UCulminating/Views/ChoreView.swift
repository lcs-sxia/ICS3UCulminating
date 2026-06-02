//
//  ChoreView.swift
//  ICS3UCulminating
//

import SwiftUI

struct ChoreView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "list.clipboard.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.purple)
                Text("Chore Content Goes Here")
                    .font(.title2)
            }
            .navigationTitle("Chore")
        }
    }
}

#Preview {
    ChoreView()
}
