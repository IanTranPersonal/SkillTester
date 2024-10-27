//
//  MainView.swift
//  SkillTester
//
//  Created by Vinh Tran on 25/10/2024.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject private var base: Base
    @State private var selectedCategory: RaceCategory? = nil
    private let atLeast = 5
    
    var body: some View {
        VStack(spacing: 16) {
            ExpandableFilterView(selectedCategory: $selectedCategory)
            if base.errorString != nil {
                Text(base.errorString ?? "")
                    .foregroundStyle(.red)
            }
            List {
                Section(header: Text("Upcoming Races")) {
                    if filteredAndSortedObjects.isEmpty {
                        EmptyView()
                    }
                    else {
                        ForEach(filteredAndSortedObjects, id: \.self) { object in
                            RaceComponentView(store: .init(model: object)) {
                                handleTimerComplete(for: object)
                            }
                        }
                    }
                }
                
                if !filteredCompletedObjects.isEmpty {
                    Section(header: Text("Completed")) {
                        ForEach(filteredCompletedObjects, id: \.self) { object in
                            CompletedRaceComponentView(store: .init(model: object))
                        }
                    }
                }
            }
            .task {
                try? await base.grabData()
            }
            .refreshable {
                Task {
                    try await base.grabData()
                    base.errorString = nil
                }
            }
            .scrollContentBackground(.hidden)
            .listRowSeparator(.hidden)
        }
        
    }
}

#Preview {
    MainView().environmentObject(Base())
}

private extension MainView {
    
    var filteredAndSortedObjects: [RaceSummaryUsable] {
        let sorted = base.objects.sorted(by: { $1.raceStart > $0.raceStart })
        
        if let selectedCategory {
            return sorted.filter { race in
                race.categoryId == selectedCategory.rawValue
            }
        }
        return Array(sorted.prefix(atLeast))
    }
    
    var filteredCompletedObjects: [RaceSummaryUsable] {
        let sorted = base.completedObjects.sorted(by: {$1.raceStart > $0.raceStart})
        if let selectedCategory {
            return sorted.filter { race in
                race.categoryId == selectedCategory.rawValue
            }
        }
        return sorted
    }
    
    func handleTimerComplete(for object: RaceSummaryUsable) {
        base.addAndRemoveRace(object: object)
        if base.objects.count < atLeast {
            Task {
                try? await base.grabData()
            }
        }
    }
}
