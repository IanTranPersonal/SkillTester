//
//  AnotherTestView.swift
//  SkillTester
//
//  Created by Vinh Tran on 26/10/2024.
//

import SwiftUI

struct CountdownTimerView: View {
    let targetDate: Date
    let onTimerComplete: () -> Void  // Callback for when timer hits zero
    @State private var timeRemaining: TimeInterval = 0
    @State private var timer: Timer? = nil
    
    init(seconds: Int, onTimerComplete: @escaping () -> Void) {
        self.targetDate = Date(timeIntervalSince1970: TimeInterval(seconds))
        self.onTimerComplete = onTimerComplete
    }
    
    var body: some View {
        HStack {
            Text(timeString(from: timeRemaining))
                .font(.caption)
                .onAppear {
                    calculateTimeRemaining()
                    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                        calculateTimeRemaining()
                    }
                }
                .onDisappear {
                    timer?.invalidate()
                    timer = nil
                }
        }
    }
    
    private func calculateTimeRemaining() {
        let currentTime = Date()
        let remaining = targetDate.timeIntervalSince(currentTime)
        
        if remaining <= 0 {
            timer?.invalidate()
            timer = nil
            timeRemaining = 0
            onTimerComplete()  // Call the callback when timer hits zero
        }
        else {
            timeRemaining = remaining
        }
    }
    
    private func timeString(from timeInterval: TimeInterval) -> String {
        if timeInterval <= 0 {
            return "Started"
        }
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        
        return String(format: "%02d:%02d", minutes, seconds) + " Remaining"
    }
}
