//
//  DebugConfiguration.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import Foundation

// MARK: - DebugConfigurationType

public enum DebugConfigurationType {
    case userDefaults
    case directory
    case coreData
    case userNotifications
    
    var displayName: String {
        switch self {
        case .userDefaults:
            return "User Defaults"
        case .directory:
            return "Directory"
        case .coreData:
            return "Core Data"
        case .userNotifications:
            return "User Notifications"
        }
    }
}

// MARK: - DebugConfiguration

public protocol DebugConfiguration {
    
    var type: DebugConfigurationType { get }
    
}
