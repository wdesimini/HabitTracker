//
//  DataService+User.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/11/21.
//

import Foundation

extension DataService where T == User {
    var currentUser: User? {
        guard let service = localService else {
            return objectsById.values.first
        }
        
        guard let userId = UserDefaults.standard.userId else {
            return nil
        }
        
        return objectsById[userId]
    }
    
    mutating func createUser() throws {
        let user = User(
            id: UUID(),
            habitIds: Set<UUID>(),
            taskIds: Set<UUID>(),
            username: ""
        )
        
        let response = execute(request: .create(object: user))
        
        if let error = response.error {
            throw error
        }
        
        try? UserDefaults.standard.update(userId: user.id)
    }
    
    mutating func loadUser() throws {
        guard localService != nil else {
            return
        }
        
        if let userId = UserDefaults.standard.userId {
            try load(objectId: userId)
        } else {
            try createUser()
        }
    }
}
