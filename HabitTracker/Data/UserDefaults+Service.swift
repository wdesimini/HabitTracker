//
//  UserDefaults+Service.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/11/21.
//

import Foundation

extension UserDefaults {
    enum Key: String, CaseIterable {
        case userId
    }
    
    private func object<T: Decodable>(key: Key) -> T? {
        data(forKey: key.rawValue).flatMap {
            try? JSONDecoder().decode(T.self, from: $0)
        }
    }
    
    private func set<T: Encodable>(object: T, key: Key) throws {
        let data = try JSONEncoder().encode(object)
        setValue(data, forKey: key.rawValue)
    }
    
    var userId: UUID? {
        let idString: String? = object(key: .userId)
        return idString.flatMap { UUID(uuidString: $0) }
    }
    
    func update(userId: UUID) throws {
        try set(object: userId.uuidString, key: .userId)
    }
}
