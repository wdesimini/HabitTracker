//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/12/21.
//

import Combine
import SwiftUI

protocol HabitViewModelInput: ObservableObject {
    var habitStreaks: [Habit.Streak] { get }
    var habitTitle: String { get }
}

class HabitViewModel: HabitViewModelInput {
    @ObservedObject var data: DataManager
    private let habitId: UUID
    @Published var habitStreaks: [Habit.Streak]
    @Published var habitTitle: String
    private var observer: AnyCancellable?
    
    init(
        data: DataManager = .shared,
        habit: Habit
    ) {
        self.data = data
        self.habitId = habit.id
        let streaksById = data.streaksDataService.objectsById
        self.habitStreaks = habit.streakIds.compactMap { streaksById[$0] }
        self.habitTitle = habit.title
        bind()
    }
    
    private func bind() {
        observer = data.$habitsDataService.sink { [weak self] in
            self?.didUpdate(habitsService: $0)
        }
    }
    
    private func didUpdate(habitsService: DataService<Habit>) {
        guard let habit = habitsService.objectsById[habitId] else {
            #warning("tbd - handle deleting habit?")
            return
        }
        
        let streaksById = data.streaksDataService.objectsById
        habitStreaks = habit.streakIds.compactMap { streaksById[$0] }
        habitTitle = habit.title
    }
}

