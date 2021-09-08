//
//  HabitTrackEntryViewModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/7/21.
//

import Combine
import SwiftUI

protocol HabitTrackEntryViewModelInput: ObservableObject {
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

class HabitTrackEntryViewModel: HabitTrackEntryViewModelInput {
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
    
    private func save(habit: Habit, habitTrack: HabitTrack) {
        let manager = DataManager.shared
        
        let _ = manager.habitsDataService.execute(
            request: .create(object: habit)
        )
        
        let _ = manager.habitTracksDataService.execute(
            request: .create(object: habitTrack)
        )
    }
    
    func startHabitTrack() {
        let habit = Habit(
            id: UUID(),
            title: habitTitle,
            userId: UUID()
        )
        let habitTrack = HabitTrack(
            end: nil,
            id: UUID(),
            habitId: habit.id,
            start: Date().timeIntervalSince1970
        )
        
        save(habit: habit, habitTrack: habitTrack)
        
        dismissHandler()
    }
}
