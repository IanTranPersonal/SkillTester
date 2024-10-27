//
//  FilterView.swift
//  SkillTester
//
//  Created by Vinh Tran on 27/10/2024.
//

import SwiftUI

struct ExpandableFilterView: View {
    @Binding var selectedCategory: RaceCategory?
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            Button {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    Text("Filter")
                        .foregroundColor(.primary)
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.primary)
                        .font(.caption)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
            }
            
            if isExpanded {
                RaceCategoryFilterView(selectedCategory: $selectedCategory)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
    }
}

#Preview("Expandable") {
    ExpandableFilterView(selectedCategory: .constant(RaceCategory.horseRacing))
}

struct RaceCategoryFilterView: View {
    @Binding var selectedCategory: RaceCategory?
    
    var body: some View {
            HStack(alignment: .center, spacing: 12) {
                ForEach(RaceCategory.allCases, id: \.self) { category in
                    FilterComponent(
                        title: category.displayName,
                        isSelected: selectedCategory == category
                    ) {
                        withAnimation(.easeInOut) {
                            // Toggle selection: set to nil if already selected
                            selectedCategory = (selectedCategory == category) ? nil : category
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
    }
}

#Preview("All Items") {
    RaceCategoryFilterView(selectedCategory: .constant(RaceCategory.horseRacing))
}

struct FilterComponent: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.blue : Color.gray.opacity(0.2))
                )
                .foregroundColor(isSelected ? .white : .primary)
        }
    }
}
