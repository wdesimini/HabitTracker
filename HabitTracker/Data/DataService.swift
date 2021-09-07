//
//  DataService.swift
//  HabitTracker
//
//  Created by Wilson Desimini on 9/6/21.
//

import Foundation

struct DataService<T: DataServiceable> {
    var objectsById = [UUID: T]()
    
    mutating func execute(request: Request) -> Response {
        var response = Response()
        
        switch request {
        case .create(let object):
            objectsById[object.id] = object
        case .delete(let object):
            objectsById[object.id] = nil
        case .read(let objectId):
            response.object = objectsById[objectId]
        case .update(let object):
            objectsById[object.id] = object
        }
        
        return response
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
