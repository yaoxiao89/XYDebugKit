//
//  CoreDataDebugConfiguration.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreData

public struct CoreDataDebugConfiguration: DebugConfiguration {
    
    public var type: DebugConfigurationType = .coreData
    
    let container: NSPersistentContainer
    
    public init(container: NSPersistentContainer) {
        self.container = container
    }
    
}
