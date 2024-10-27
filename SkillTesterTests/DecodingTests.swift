//
//  DecodingTests.swift
//  SkillTester
//
//  Created by Vinh Tran on 27/10/2024.
//

import XCTest
@testable import SkillTester

final class CodableTests: XCTestCase {

    func testRaceAPIResponseDecoding() throws {
        let json = """
        {
            "status": 200,
            "data": {
                "next_to_go_ids": ["id1", "id2"],
                "race_summaries": {
                    "id1": {
                        "race_id": "race1",
                        "race_name": "Race 1",
                        "race_number": 1,
                        "meeting_id": "meeting1",
                        "meeting_name": "Meeting 1",
                        "category_id": "4a2788f8-e825-4d36-9894-efd4baf1cfae",
                        "advertised_start": { "seconds": 1609459200 },
                        "venue_id": "venue1",
                        "venue_name": "Venue 1",
                        "venue_state": "State 1",
                        "venue_country": "Country 1"
                    }
                }
            }
        }
        """.data(using: .utf8)!

        let decodedResponse = try JSONDecoder().decode(RaceAPIResponse.self, from: json)
        XCTAssertEqual(decodedResponse.status, 200)
        XCTAssertEqual(decodedResponse.data.nextToGoIds, ["id1", "id2"])
        XCTAssertEqual(decodedResponse.data.raceSummaries.count, 1)
    }

    func testResponseDataDecoding() throws {
        let json = """
        {
            "next_to_go_ids": ["id1", "id2"],
            "race_summaries": {
                "id1": {
                    "race_id": "race1",
                    "race_name": "Race 1",
                    "race_number": 1,
                    "meeting_id": "meeting1",
                    "meeting_name": "Meeting 1",
                    "category_id": "4a2788f8-e825-4d36-9894-efd4baf1cfae",
                    "advertised_start": { "seconds": 1609459200 },
                    "venue_id": "venue1",
                    "venue_name": "Venue 1",
                    "venue_state": "State 1",
                    "venue_country": "Country 1"
                }
            }
        }
        """.data(using: .utf8)!

        let decodedData = try JSONDecoder().decode(ResponseData.self, from: json)
        XCTAssertEqual(decodedData.nextToGoIds, ["id1", "id2"])
        XCTAssertEqual(decodedData.raceSummaries.count, 1)
    }

    func testRaceSummaryDecoding() throws {
        let json = """
        {
            "race_id": "race1",
            "race_name": "Race 1",
            "race_number": 1,
            "meeting_id": "meeting1",
            "meeting_name": "Meeting 1",
            "category_id": "4a2788f8-e825-4d36-9894-efd4baf1cfae",
            "advertised_start": { "seconds": 1609459200 },
            "venue_id": "venue1",
            "venue_name": "Venue 1",
            "venue_state": "State 1",
            "venue_country": "Country 1"
        }
        """.data(using: .utf8)!

        let decodedSummary = try JSONDecoder().decode(RaceSummary.self, from: json)
        XCTAssertEqual(decodedSummary.raceId, "race1")
        XCTAssertEqual(decodedSummary.raceName, "Race 1")
        XCTAssertEqual(decodedSummary.raceNumber, 1)
        XCTAssertEqual(decodedSummary.meetingId, "meeting1")
        XCTAssertEqual(decodedSummary.meetingName, "Meeting 1")
        XCTAssertEqual(decodedSummary.categoryId, "4a2788f8-e825-4d36-9894-efd4baf1cfae")
        XCTAssertEqual(decodedSummary.advertisedStart.seconds, 1609459200)
    }

    func testAdvertisedStartDecoding() throws {
        let json = """
        {
            "seconds": 1609459200
        }
        """.data(using: .utf8)!

        let decodedStart = try JSONDecoder().decode(AdvertisedStart.self, from: json)
        XCTAssertEqual(decodedStart.seconds, 1609459200)
    }

    func testRaceSummaryUsableHashable() throws {
        let summary1 = RaceSummaryUsable(raceID: "race1", raceName: "Race 1", meetingName: "Meeting 1", raceNumber: 1, raceStart: 1609459200, categoryId: "4a2788f8-e825-4d36-9894-efd4baf1cfae")
        let summary2 = RaceSummaryUsable(raceID: "race2", raceName: "Race 2", meetingName: "Meeting 2", raceNumber: 2, raceStart: 1609459300, categoryId: "9daef0d7-bf3c-4f50-921d-8e818c60fe61")
        XCTAssertNotEqual(summary1, summary2)
    }
}
