//
//  Habit.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import Foundation

struct Habit: Hashable, Identifiable, DataServiceable {
    let id: UUID
    var streakIds: Set<UUID>
    var title: String
    let userId: UUID
}
