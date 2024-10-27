//
//  Base.swift
//  SkillTester
//
//  Created by Vinh Tran on 27/10/2024.
//

import SwiftUI
@MainActor
class Base: ObservableObject {
    @Published var objects: [RaceSummaryUsable] = []
    @Published var completedObjects: Set<RaceSummaryUsable> = []
    @Published var errorString: String?
    func grabData() async throws {
        do {
            guard let url = URL(string: "https://api.neds.com.au/rest/v1/racing/?method=nextraces&count=10") else { throw URLError(.badURL)}
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { throw URLError(.badServerResponse) }
            let decodedResponse = try? JSONDecoder().decode(RaceAPIResponse.self, from: data)
            guard let mappedResponse = decodedResponse?.data.raceSummaries.values else { throw URLError(.cannotDecodeContentData) }
            objects.removeAll()
            objects.append(contentsOf: mappedResponse.compactMap({RaceSummaryUsable(
                raceID: $0.raceId,
                raceName: $0.raceName,
                meetingName: $0.meetingName,
                raceNumber: $0.raceNumber,
                raceStart: $0.advertisedStart.seconds,
                categoryId: $0.categoryId
            )}))
            errorString = nil
        }
        catch {
            errorString = error.localizedDescription
        }
    }
    
    func addAndRemoveRace(object: RaceSummaryUsable) {
        // Add to completed section
        completedObjects.insert(object)
        // Remove from current section
        DispatchQueue.main.async {
            withAnimation {
                self.objects.removeAll { $0.raceID == object.raceID }
            }
        }
        // Remove from completed section after 1 minute
        DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
            withAnimation {
                if let itemToRemove = self.completedObjects.first(where: { $0.raceID == object.raceID }) {
                        self.completedObjects.remove(itemToRemove)
                    }
            }
        }
    }
}


enum APIError: Error {
    case genericError
    case noData
}
