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
    @Published var streaksDataService: DataService<Habit.Streak>
    @Published var usersDataService: DataService<User>
    
    private init() {
        let localDatabaseService = FileManager.default
        habitsDataService = DataService<Habit>(localService: localDatabaseService)
        streaksDataService = DataService<Habit.Streak>(localService: localDatabaseService)
        usersDataService = DataService<User>(localService: localDatabaseService)
    }
    
    func resetData() throws {
        for key in UserDefaults.Key.allCases {
            UserDefaults.standard.removeObject(forKey: key.rawValue)
        }
        
        try FileManager.default.deleteDocumentsDirectoryContents()
    }
}
