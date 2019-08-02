//
//  NSManagedObject+Debug.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreData

extension NSManagedObject {
    
    func attributesDescription() -> String {
        let names = entity.attributesByName
        let descriptions = names.map { (key, description) -> String in
            let attrValue = "\(value(forKey: key) ?? "-")"
            return "\(key): \(attrValue)"
        }
        return descriptions.joined(separator: "\n")
    }
    
}
