//
//  UserNotificationsConfiguration.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UserNotifications

public class UserNotificationsConfiguration: DebugConfiguration {
    
    public var type: DebugConfigurationType = .userNotifications
    
    let notificationCenter: UNUserNotificationCenter
    
    public init(notificationCenter: UNUserNotificationCenter) {
        self.notificationCenter = notificationCenter
    }
    
}
