//
//  HabitStreaksListViewModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/7/21.
//

import Combine
import SwiftUI

protocol HabitStreaksListViewModelInput: ObservableObject {
    var addStreakButtonTitle: String { get }
    var streaks: [Habit.Streak] { get }
    var habit: Habit { get }
    func add(streak: Habit.Streak)
}

class HabitStreaksListViewModel: HabitStreaksListViewModelInput {
    @ObservedObject private var dataManager = DataManager.shared
    @Published private(set) var habit: Habit
    private var habitObserver: AnyCancellable?
    
    init(habit: Habit) {
        self.habit = habit
        bind()
    }
    
    var addStreakButtonTitle: String {
        "New Streak"
    }
    
    var streaks: [Habit.Streak] {
        let streaksById = dataManager.streaksDataService.objectsById
        let streaks = habit.streakIds.compactMap { streaksById[$0] }
        return streaks.sorted { $0.start < $1.start }
    }
    
    func add(streak: Habit.Streak) {
        #warning("tbd - handle this response")
        let _ = dataManager.streaksDataService.execute(
            request: .create(object: streak)
        )
        
        var habit = self.habit
        habit.streakIds.insert(streak.id)
        #warning("tbd - handle this response")
        let _ = dataManager.habitsDataService.execute(
            request: .update(object: habit)
        )
    }
    
    private func bind() {
        let habitId = habit.id
        
        habitObserver =
            dataManager.$habitsDataService.sink { [weak self] in
                self?.habit = $0.objectsById[habitId]!
            }
    }
}
