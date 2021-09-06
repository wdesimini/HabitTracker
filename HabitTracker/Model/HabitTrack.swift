//
//  HabitTrack.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import Foundation

struct HabitTrack: Identifiable {
    var end: TimeInterval?
    let id: UUID
    let habitId: UUID
    let start: TimeInterval
}
