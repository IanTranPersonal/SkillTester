//
//  EmptyView.swift
//  SkillTester
//
//  Created by Vinh Tran on 27/10/2024.
//
import SwiftUI

struct EmptyView: View {
    var body: some View {
        Text("No upcoming races in this category")
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .center)
            .listRowBackground(Color.clear)
    }
}

#Preview {
    EmptyView()
}
