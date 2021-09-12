//
//  HabitStreaksListModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import Foundation

protocol HabitStreaksListModelInput {
    var streaks: [Habit.Streak] { get }
    func dateText(streak: Habit.Streak) -> String
    func durationText(streak: Habit.Streak) -> String
}

class HabitStreaksListModel: HabitStreaksListModelInput {
    let streaks: [Habit.Streak]
    
    init(streaks: [Habit.Streak]) {
        self.streaks = streaks
    }
    
    func dateText(streak: Habit.Streak) -> String {
        let timestamp = streak.start
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        let date = Date(timeIntervalSince1970: timestamp)
        return formatter.string(from: date)
    }
    
    func durationText(streak: Habit.Streak) -> String {
        guard let end = streak.end else {
            return "Active"
        }
        
        let duration = Int(end - streak.start)
        return "\(duration) seconds"
    }
}
