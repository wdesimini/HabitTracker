//
//  DataServiceable.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import Foundation

protocol DataServiceable: Codable {
    var id: UUID { get }
}
