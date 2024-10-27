//
//  RaceCategory.swift
//  SkillTester
//
//  Created by Vinh Tran on 27/10/2024.
//

enum RaceCategory: String, CaseIterable {
    case horseRacing = "4a2788f8-e825-4d36-9894-efd4baf1cfae"
    case greyhound = "9daef0d7-bf3c-4f50-921d-8e818c60fe61"
    case harness = "161d9be2-e909-4326-8c2c-35ed71fb460b"
    
    var displayName: String {
        switch self {
        case .horseRacing: return "Horses"
        case .greyhound: return "Greyhounds"
        case .harness: return "Harness"
        }
    }
}
