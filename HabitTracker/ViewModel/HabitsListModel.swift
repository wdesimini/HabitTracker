//
//  HabitsListModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/11/21.
//

import Combine
import SwiftUI

protocol HabitsListModelInput: ObservableObject {
    var habits: [Habit] { get }
    func currentStreak(habit: Habit) -> Habit.Streak?
}

class HabitsListModel: HabitsListModelInput {
    @ObservedObject var data: DataManager
    @Published private(set) var habits: [Habit]
    private let userId: UUID
    private var observer: AnyCancellable?
    
    init(data: DataManager = .shared, userId: UUID) {
        self.data = data
        let usersById = data.usersDataService.objectsById
        let user = usersById[userId]!
        let habitIds = user.habitIds
        let habitsById = data.habitsDataService.objectsById
        self.habits = habitIds.compactMap { habitsById[$0] }
        self.userId = userId
        bind()
    }
    
    private func bind() {
        observer = data.$usersDataService.sink { [weak self] in
            guard let self = self else {
                return
            }
            
            let usersById = $0.objectsById
            let user = usersById[self.userId]!
            let habitIds = user.habitIds
            let habitsById = self.data.habitsDataService.objectsById
            self.habits = habitIds.compactMap { habitsById[$0] }
        }
    }
    
    func currentStreak(habit: Habit) -> Habit.Streak? {
        let streaksById = data.streaksDataService.objectsById
        let streaks = habit.streakIds.compactMap { streaksById[$0] }
        return streaks.sorted { $0.start < $1.start }.first
    }
}
