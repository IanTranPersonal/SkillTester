//
//  SkillTesterApp.swift
//  SkillTester
//
//  Created by Vinh Tran on 26/10/2024.
//

import SwiftUI

@main
struct SkillTesterApp: App {
    var base = Base()
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(base)
        }
    }
}
