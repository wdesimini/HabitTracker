//
//  ContentViewModel.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/7/21.
//

import Combine
import SwiftUI

protocol ContentViewModelInput: ObservableObject {
    var habitTracksSectionTitle: String { get }
    var username: String { get }
    var userSectionTitle: String { get }
}

class ContentViewModel: ContentViewModelInput {
    @ObservedObject private var dataManager = DataManager.shared
    @Published private var user: User?
    private var userobserver: AnyCancellable?
    
    init() {
        do {
            try dataManager.usersDataService.loadUser()
        } catch {
            print(error)
        }
        
        bind()
    }
    
    var habitTracksSectionTitle: String {
        "Habit Tracks"
    }
    
    var username: String {
        user?.username ?? "No User"
    }
    
    var userSectionTitle: String {
        "User"
    }
    
    private func bind() {
        userobserver =
            dataManager.$usersDataService.sink { [weak self] in
                let userId = UserDefaults.standard.userId!
                self?.user = $0.objectsById[userId]
            }
    }
}
