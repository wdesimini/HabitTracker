//
//  Task.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import Foundation

struct Task: DataServiceable {
    let added: TimeInterval
    var done: TimeInterval?
    var due: TimeInterval?
    let id: UUID
    var title: String
}
