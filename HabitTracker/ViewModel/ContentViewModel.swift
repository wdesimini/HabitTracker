//
//  ContentViewModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/7/21.
//

import Combine
import SwiftUI

protocol ContentViewModelInput: ObservableObject {
    var currentStreaksSectionTitle: String { get }
    var dataManager: DataManager { get }
    var habitsListViewModel: HabitsListModel { get }
    var userId: UUID { get }
    var username: String { get }
    var userSectionTitle: String { get }
}

class ContentViewModel: ContentViewModelInput {
    @ObservedObject var dataManager: DataManager
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
    
    var currentStreaksSectionTitle: String {
        "Current Habit Streaks"
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
    
    private func bind() {
        userObserver =
            dataManager.$usersDataService.sink { [weak self] in
                self?.user = $0.currentUser
            }
    }
}
