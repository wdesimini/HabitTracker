//
//  User.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import Foundation

struct User {
    let id: UUID
    var habitIds: Set<UUID>
    var habitTrackIds: Set<UUID>
    var username: String
}
