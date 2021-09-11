//
//  HabitStreakEntryViewModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/7/21.
//

import Combine
import SwiftUI

protocol HabitStreakEntryViewModelInput: ObservableObject {
    var cancelButtonTitle: String { get }
    var habitSectionTitle: String { get }
    var habitTitle: String { get set }
    var habitTitleTextFieldPlaceholder: String { get }
    var startButtonIsDisabled: Bool { get }
    var startButtonTitle: String { get }
    
    init(dismissHandler: @escaping () -> Void)
    
    func cancelHabitTrackEntry()
    func startHabitTrack()
}

class HabitStreakEntryViewModel: HabitStreakEntryViewModelInput {
    private let dismissHandler: () -> Void
    var habitTitle = "" {
        didSet {
            startButtonIsDisabled = habitTitle.isEmpty
        }
    }
    @Published var startButtonIsDisabled = true
    
    required init(dismissHandler: @escaping () -> Void) {
        self.dismissHandler = dismissHandler
    }
    
    var cancelButtonTitle: String {
        "Cancel"
    }
    
    var habitSectionTitle: String {
        "Habit"
    }
    
    var habitTitleTextFieldPlaceholder: String {
        "Enter Habit Title"
    }
    
    var startButtonTitle: String {
        "Start"
    }
    
    func cancelHabitTrackEntry() {
        dismissHandler()
    }
    
    private func save(habit: Habit, streak: Habit.Streak) {
        let manager = DataManager.shared
        
        let _ = manager.habitsDataService.execute(
            request: .create(object: habit)
        )
        
        let _ = manager.streaksDataService.execute(
            request: .create(object: streak)
        )
    }
    
    func startHabitTrack() {
        let streak = Habit.Streak(
            end: nil,
            id: UUID(),
            start: Date().timeIntervalSince1970
        )
        #warning("tbd - load user id here, or take user id out of habit objects?")
        let habit = Habit(
            id: UUID(),
            streakIds: Set([streak.id]),
            title: habitTitle,
            userId: UUID()
        )
        
        save(habit: habit, streak: streak)
        
        dismissHandler()
    }
}
