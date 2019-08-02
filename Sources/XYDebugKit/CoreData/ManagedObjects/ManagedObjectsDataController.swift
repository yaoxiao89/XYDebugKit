//
//  ManagedObjectsDataController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreData

class ManagedObjectsDataController {
    
    let managedObjects: [NSManagedObject]
    
    init(entity: NSEntityDescription, container: NSPersistentContainer) {
        let request = NSFetchRequest<NSManagedObject>()
        request.entity = entity
        
        do {
            managedObjects = try container.viewContext.fetch(request)
        } catch {
            managedObjects = []
        }
    }
    
    func value(at indexPath: IndexPath) -> NSManagedObject {
        return managedObjects[indexPath.row]
    }
    
}
