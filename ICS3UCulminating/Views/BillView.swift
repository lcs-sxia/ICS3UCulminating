//
//  BillView.swift
//  ICS3UCulminating
//

import SwiftUI

struct BillView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "banknote.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(.green)
                Text("Bill Content Goes Here")
                    .font(.title2)
            }
            .navigationTitle("Bill")
        }
    }
}

#Preview {
    BillView()
}
