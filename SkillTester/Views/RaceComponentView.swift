//
//  RaceComponentView.swift
//  SkillTester
//
//  Created by Vinh Tran on 26/10/2024.
//
import SwiftUI

struct RaceComponentView: View {
    @ObservedObject var store: Store
    let onTimerComplete: () -> Void
    
    private var timeDisplay: String {
        let date = Date(timeIntervalSince1970: TimeInterval(store.model.raceStart))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(store.model.meetingName)
                Text("Race Number: \(store.model.raceNumber)")
                    .font(.caption)
            }
            Spacer()
            VStack {
                Text(timeDisplay)
                    .font(.title2)
                CountdownTimerView(seconds: store.model.raceStart) {
                    onTimerComplete()
                }
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 12, style: .circular)
                .fill(AngularGradient(colors: [.green, .cyan], center: .center, angle: .degrees(45)))
                .shadow(color: .primary, radius: 5, y: 5)
        }
    }
}

extension RaceComponentView {
    final class Store: ObservableObject {
        @Published var model: RaceSummaryUsable
        
        init(model: RaceSummaryUsable) {
            self.model = model
        }
    }
}

#Preview {
    let dummyStore = RaceSummaryUsable(raceID: UUID().uuidString, raceName: "Test", meetingName: "Test Meeting", raceNumber: 12, raceStart: 1729846140, categoryId: "4a2788f8-e825-4d36-9894-efd4baf1cfae")
    RaceComponentView(store: .init(model: dummyStore)) {}
        .padding()
}
