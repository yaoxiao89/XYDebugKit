//
//  UserDefaultsDebugConfiguration.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import Foundation

public struct UserDefaultsDebugConfiguration: DebugConfiguration {
    
    public var type: DebugConfigurationType = .userDefaults
    
    let userDefaults: UserDefaults
    let suiteName: String?
    let predicate: NSPredicate?
    
    public init(userDefaults: UserDefaults, suiteName: String? = nil, predicate: NSPredicate? = nil) {
        self.userDefaults = userDefaults
        self.suiteName = suiteName == nil ? "Standard" : suiteName
        self.predicate = predicate
    }
    
}
