//
//  HabitEntryViewModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import SwiftUI

protocol HabitEntryViewModelInput: ObservableObject {
    var cancelButtonTitle: String { get }
    var habitTitle: String { get set }
    var handler: (Habit?, Habit.Streak?) -> Void { get }
    var submitButtonDisabled: Bool { get }
    var submitButtonTitle: String { get }
    var textFieldTitleKey: String { get }
    func cancelTapped()
    func submitTapped()
}

class HabitEntryViewModel: HabitEntryViewModelInput {
    let cancelButtonTitle = "Cancel"
    @Published var habitTitle = ""
    let handler: (Habit?, Habit.Streak?) -> Void
    let submitButtonTitle = "Start"
    let textFieldTitleKey = "Habit Title"
    let userId: UUID
    
    init(
        userId: UUID,
        handler: @escaping (Habit?, Habit.Streak?) -> Void
    ) {
        self.userId = userId
        self.handler = handler
    }
    
    private var habitAndStreak: (Habit, Habit.Streak) {
        let streak = Habit.Streak(
            end: nil,
            id: UUID(),
            start: Date().timeIntervalSince1970
        )
        let habit = Habit(
            id: UUID(),
            streakIds: [streak.id],
            title: habitTitle,
            userId: userId
        )
        return (habit, streak)
    }
    
    var submitButtonDisabled: Bool {
        habitTitle.isEmpty
    }
    
    func cancelTapped() {
        handler(nil, nil)
    }
    
    func submitTapped() {
        let (habit, streak) = habitAndStreak
        handler(habit, streak)
    }
}
