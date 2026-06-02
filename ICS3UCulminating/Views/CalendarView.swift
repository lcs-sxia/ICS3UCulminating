//
//  CalendarView.swift
//  ICS3UCulminating
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "calendar")
                    .font(.system(size: 60))
                    .foregroundStyle(.red)
                Text("Calendar Content Goes Here")
                    .font(.title2)
            }
            .navigationTitle("Calendar")
        }
    }
}

#Preview {
    CalendarView()
}
