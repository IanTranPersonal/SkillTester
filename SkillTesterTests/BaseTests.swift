//
//  BaseTests.swift
//  SkillTesterTests
//
//  Created by Vinh Tran on 25/10/2024.
//

import XCTest
@testable import SkillTester

final class BaseTests: XCTestCase {
    private var base: Base!
    
    @MainActor
    override func setUp() async throws {
        base = Base()
    }
    
    override func tearDown() async throws {
        base = nil
    }

    func testItemCount() async throws {
        try await base.grabData()
        await MainActor.run{
            XCTAssertEqual(base.objects.count, 10)
        }
    }
    
    func testMapping() async throws {
        try await base.grabData()
        guard let firstObject = await base.objects.first else {
            XCTFail("Objects array is empty")
            return
        }
        XCTAssertNotNil(firstObject.raceID)
        XCTAssertNotNil(firstObject.raceStart)
        XCTAssertNotNil(firstObject.raceNumber)
        XCTAssertNotNil(firstObject.meetingName)
        XCTAssertNotNil(firstObject.categoryId)
    }
}
