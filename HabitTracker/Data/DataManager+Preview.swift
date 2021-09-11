//
//  DataManager+Preview.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/11/21.
//

import Foundation

extension DataManager {
    private var sampleData: (User, Habit, Habit.Streak) {
        let streak = Habit.Streak(
            end: nil,
            id: UUID(),
            start: Date().timeIntervalSince1970 - 3600
        )
        let userId = UUID()
        let habit = Habit(
            id: UUID(),
            streakIds: [streak.id],
            title: "Exercise",
            userId: userId
        )
        let user = User(
            id: userId,
            habitIds: [habit.id],
            username: "Willy"
        )
        return (user, habit, streak)
    }
    
    func loadPreviewData() {
        let data = sampleData
        let _ = streaksDataService.execute(request: .create(object: data.2))
        let _ = habitsDataService.execute(request: .create(object: data.1))
        let _ = usersDataService.execute(request: .create(object: data.0))
    }
}
