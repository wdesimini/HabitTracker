//
//  DatabaseService.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/11/21.
//

import Foundation

protocol DatabaseService {
    func appDirectory() throws -> URL
    func create<T: Encodable>(file: T, at url: URL) throws
    func read<T: Decodable>(fileAt url: URL) throws -> T?
    func update<T: Encodable>(file: T, at url: URL) throws
    func delete(itemAt url: URL) throws
}

extension DatabaseService {
    func url<T: DataServiceable>(file: T) throws -> URL {
        try appDirectory()
            .appendingPathComponent(T.directoryName)
            .appendingPathComponent(file.id.uuidString)
    }
    
    func create<T: DataServiceable>(file: T) throws {
        let url = try self.url(file: file)
        try create(file: file, at: url)
    }
    
    func read<T: DataServiceable>(fileWithId fileId: UUID) throws -> T? {
        let url = try appDirectory()
            .appendingPathComponent(T.directoryName)
            .appendingPathComponent(fileId.uuidString)
        return try read(fileAt: url)
    }
    
    func update<T: DataServiceable>(file: T) throws {
        let url = try self.url(file: file)
        try update(file: file, at: url)
    }
    
    func delete<T: DataServiceable>(file: T) throws {
        let url = try self.url(file: file)
        try delete(itemAt: url)
    }
}
