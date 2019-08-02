//
//  UserDefaultsDataController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import Foundation

// MARK: - UserDefaultsDataController

class UserDefaultsDataController {
    
    private let userDefaults: UserDefaults
    let keys: [String]
    
    init(configuration: UserDefaultsDebugConfiguration) {
        let userDefaults = configuration.userDefaults
        self.userDefaults = userDefaults
        var keys = Array(userDefaults.dictionaryRepresentation().keys)
        if let predicate = configuration.predicate {
            keys = keys.filter({ predicate.evaluate(with: $0) })
        }
        self.keys = keys
    }
    
    func value(forKey key: String) -> String {
        guard let val = userDefaults.value(forKey: key) else { return "-" }
        return String(describing: val)
    }
    
}
