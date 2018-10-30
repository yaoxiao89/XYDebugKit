//
//  ManagedObjectDataController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreData

// MARK: - Attribute

struct Attribute {
    let name: String
    let value: String
}

// MARK: - Relationship

struct Relationship {
    let name: String
    let managedObjects: [NSManagedObject]
}

// MARK: - ManagedObjectDataController

class ManagedObjectDataController {
    
    let attributes: [Attribute]
    let relationships: [Relationship]
    
    init(managedObject: NSManagedObject, container: NSPersistentContainer) {
        let entity = managedObject.entity
        let descriptions = entity.attributesByName
        attributes = descriptions.map({ (key, description) -> Attribute in
            let attrValue = "\(managedObject.value(forKey: key) ?? "-")"
            return Attribute(name: key, value: attrValue)
        })
        
        let rDescriptions = entity.relationshipsByName
        relationships = rDescriptions.map({ (key, description) -> Relationship in
            let name = description.name
            let ids = managedObject.objectIDs(forRelationshipNamed: name)
            let mos = ids.map({ container.viewContext.object(with: $0) })
            return Relationship(name: name, managedObjects: mos)
        })
    }
    
}
