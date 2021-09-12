//
//  ContentViewModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/7/21.
//

import Combine
import SwiftUI

protocol ContentViewModelInput: ObservableObject {
    var addButtonTitle: String { get }
    var currentStreaksSectionTitle: String { get }
    var dataManager: DataManager { get }
    var habitEntryViewModel: HabitEntryViewModel { get }
    var habitsListViewModel: HabitsListModel { get }
    var isAddingHabit: Bool { get set }
    var userId: UUID { get }
    var username: String { get }
    var userSectionTitle: String { get }
    func addHabitTapped()
}

class ContentViewModel: ContentViewModelInput {
    @ObservedObject var dataManager: DataManager
    @Published var isAddingHabit = false
    @Published private var user: User?
    private var userObserver: AnyCancellable?
    
    init(dataManager: DataManager = .shared) {
        self.dataManager = dataManager
        
        do {
            try dataManager.usersDataService.loadUser()
        } catch {
            print(error)
        }
        
        bind()
    }
    
    var addButtonTitle: String {
        "Add"
    }
    
    var currentStreaksSectionTitle: String {
        "Current Habit Streaks"
    }
    
    var habitEntryViewModel: HabitEntryViewModel {
        HabitEntryViewModel(userId: userId) { [weak self] (habit, streak) in
            self?.didEnter(habit: habit, streak: streak)
        }
    }
    
    var habitsListViewModel: HabitsListModel {
        HabitsListModel(
            data: dataManager,
            userId: user?.id ?? UUID()
        )
    }
    
    var userId: UUID {
        user?.id ?? UUID()
    }
    
    var username: String {
        user?.username ?? "No User"
    }
    
    var userSectionTitle: String {
        "User"
    }
    
    func addHabitTapped() {
        isAddingHabit = true
    }
    
    private func bind() {
        userObserver =
            dataManager.$usersDataService.sink { [weak self] in
                self?.user = $0.currentUser
            }
    }
    
    private func didEnter(habit: Habit?, streak: Habit.Streak?) {
        if let habit = habit, let streak = streak {
            let _ = dataManager.streaksDataService.execute(
                request: .create(object: streak)
            )
            
            let _ = dataManager.habitsDataService.execute(
                request: .create(object: habit)
            )
            
            var user = self.user!
            user.habitIds.insert(habit.id)
            let _ = dataManager.usersDataService.execute(
                request: .update(object: user)
            )
        }
        
        isAddingHabit = false
    }
}
