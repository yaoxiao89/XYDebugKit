//
//  UserNotifications+Utilities.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UserNotifications

// MARK: - UNAuthorizationStatus

extension UNAuthorizationStatus {
    
    var title: String {
        switch self {
        case .authorized:
            return "Authorized"
        case .denied:
            return "Denied"
        case .notDetermined:
            return "Not Determined"
        case .provisional:
            return "Provisional"
        @unknown default:
            return "Unknown UNAuthorizationStatus"
        }
    }
    
}

// MARK: - UNNotificationSetting

extension UNNotificationSetting {
    
    var title: String {
        switch self {
        case .disabled:
            return "Disabled"
        case .enabled:
            return "Enabled"
        case .notSupported:
            return "Not Supported"
        @unknown default:
            return "Unknown UNNotificationSetting"
        }
    }
    
}

// MARK: - UNAlertStyle

extension UNAlertStyle {
    
    var title: String {
        switch self {
        case .alert:
            return "Alert"
        case .banner:
            return "Banner"
        case .none:
            return "None"
        @unknown default:
            return "Unknown UNAlertStyle"
        }
    }
    
}
