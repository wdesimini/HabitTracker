//
//  DataManager.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import Foundation

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var habitsDataService = DataService<Habit>()
    @Published var habitTracksDataService = DataService<HabitTrack>()
    @Published var usersDataService = DataService<User>()
    
    private init() {}
    
    func createUser() throws {
        let user = User(
            id: UUID(),
            habitIds: Set<UUID>(),
            habitTrackIds: Set<UUID>(),
            username: ""
        )
        
        let response = usersDataService.execute(request: .create(object: user))
        
        if let error = response.error {
            throw error
        }
        
        try? UserDefaults.standard.update(userId: user.id)
    }
    
    func loadUser() throws {
        if let userId = UserDefaults.standard.userId {
            try usersDataService.load(objectId: userId)
        } else {
            try createUser()
        }
    }
}
