//
//  CoreDataDataController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreData

// MARK: - CoreDataEntity

struct CoreDataEntity {
    
    let entity: NSEntityDescription
    
    var name: String? {
        return entity.name
    }
    
    let count: Int
    
}

// MARK: - CoreDataDataController

class CoreDataDataController {
    
    let container: NSPersistentContainer
    let entities: [CoreDataEntity]
    
    init(container: NSPersistentContainer) {
        self.container = container
        entities = container.managedObjectModel.entities.map({ (description) -> CoreDataEntity in
            let request = NSFetchRequest<NSFetchRequestResult>()
            request.entity = description
            let count = try? container.viewContext.count(for: request)
            return CoreDataEntity(entity: description, count: count ?? 0)
        })
    }
    
    func value(at indexPath: IndexPath) -> CoreDataEntity {
        return entities[indexPath.row]
    }
    
}
