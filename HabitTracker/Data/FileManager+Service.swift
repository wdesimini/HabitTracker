//
//  FileManager+Service.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/11/21.
//

import Foundation

extension FileManager: DatabaseService {
    
    // MARK: Utility
    
    func appDirectory() throws -> URL {
        try documentsDirectoryURL()
    }
    
    func directoryExists(at url: URL) -> Bool {
        var isDirectory: ObjCBool = false
        fileExists(atPath: url.path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
    
    func directoryURL(of fileURL: URL) -> URL? {
        fileURL.deletingLastPathComponent()
    }
    
    func documentsDirectoryURL() throws -> URL {
        try url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
    }
    
    func fileExists(at url: URL) -> Bool {
        fileExists(atPath: url.path)
    }
    
    // MARK: Create
    
    func create(directoryAt url: URL) throws {
        try createDirectory(
            at: url,
            withIntermediateDirectories: false,
            attributes: nil
        )
    }
    
    func create<T: Encodable>(file: T, at url: URL) throws {
        let data = try JSONEncoder().encode(file)
        
        let directoryURL = self.directoryURL(of: url)!
        
        if !directoryExists(at: directoryURL) {
            try create(directoryAt: directoryURL)
        }
        
        createFile(atPath: url.path, contents: data)
    }
    
    // MARK: Read
    
    func read<T: Decodable>(fileAt url: URL) throws -> T? {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    // MARK: Update
    
    func update<T: Encodable>(file: T, at url: URL) throws {
        try delete(itemAt: url)
        try create(file: file, at: url)
    }
    
    // MARK: Delete
    
    func delete(itemAt url: URL) throws {
        try removeItem(at: url)
    }
    
    func deleteDocumentsDirectoryContents() throws {
        let documentsDirectoryURL = try self.documentsDirectoryURL()
        let fileURLs = try contentsOfDirectory(
            at: documentsDirectoryURL,
            includingPropertiesForKeys: nil,
            options: .skipsHiddenFiles
        )
        
        for url in fileURLs {
            try removeItem(at: url)
        }
    }
}
