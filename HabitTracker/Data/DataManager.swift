//
//  DataManager.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import Foundation

class DataManager: ObservableObject {
    static let shared = DataManager()
    
    @Published var habitsDataService: DataService<Habit>
    @Published var habitTracksDataService: DataService<HabitTrack>
    @Published var usersDataService: DataService<User>
    
    private init() {
        let localDatabaseService = FileManager.default
        habitsDataService = DataService<Habit>(localService: localDatabaseService)
        habitTracksDataService = DataService<HabitTrack>(localService: localDatabaseService)
        usersDataService = DataService<User>(localService: localDatabaseService)
    }
}
