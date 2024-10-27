//
//  CompletedRaceComponentView.swift
//  SkillTester
//
//  Created by Vinh Tran on 27/10/2024.
//

import SwiftUI

struct CompletedRaceComponentView: View {
    @ObservedObject var store: Store
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(store.model.meetingName)
                Text("Race Number: \(store.model.raceNumber)")
                    .font(.caption)
            }
            Spacer()
            Text("Race Started")
                .bold()
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12, style: .circular)
                .fill(Gradient(colors: [.gray, .white]))
                .shadow(color: .primary, radius: 5, y: 5)
        }
    }
}

extension CompletedRaceComponentView {
    final class Store: ObservableObject {
        @Published var model: RaceSummaryUsable
        
        init(model: RaceSummaryUsable) {
            self.model = model
        }
    }
}

#Preview {
    let dummyStore = RaceSummaryUsable(raceID: UUID().uuidString, raceName: "Test", meetingName: "Test Meeting", raceNumber: 12, raceStart: 1729846140, categoryId: "4a2788f8-e825-4d36-9894-efd4baf1cfae")
    CompletedRaceComponentView(store: .init(model: dummyStore))
}
