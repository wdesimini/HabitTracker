//
//  DataService.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import Foundation

struct DataService<T: DataServiceable> {
    var objectsById = [UUID: T]()
    var localService: DatabaseService?
    
    mutating func execute(request: Request) -> Response {
        var response = Response()
        
        do {
            switch request {
            case .create(let object):
                try localService?.create(file: object)
                objectsById[object.id] = object
            case .delete(let object):
                try localService?.delete(file: object)
                objectsById[object.id] = nil
            case .read(let objectId):
                let object: T?
                if let cached = objectsById[objectId] {
                    object = cached
                } else {
                    object = try localService?.read(fileWithId: objectId)
                }
                response.object = object
            case .update(let object):
                try localService?.update(file: object)
                objectsById[object.id] = object
            }
        } catch {
            response.error = error
        }
        
        return response
    }
    
    mutating func load(objectId: UUID) throws {
        let object: T? = try localService?.read(fileWithId: objectId)
        objectsById[objectId] = object
    }
}

extension DataService {
    enum Request {
        case create(object: T)
        case delete(object: T)
        case read(objectId: UUID)
        case update(object: T)
    }
    
    struct Response {
        var error: Error?
        var object: T?
    }
}
