//
//  HabitStreak.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/11/21.
//

import Foundation

extension Habit {
    struct Streak: Identifiable, DataServiceable {
        var end: TimeInterval?
        let id: UUID
        let start: TimeInterval
    }
}
