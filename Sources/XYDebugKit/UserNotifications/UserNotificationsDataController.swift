//
//  UserNotificationsDataController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UserNotifications

class UserNotificationsDataController {
    
    let center: UNUserNotificationCenter
    private var dispatchGroup: DispatchGroup?

    private(set) var settings: UNNotificationSettings?
    private(set) var categories: [UNNotificationCategory] = []
    private(set) var pendingRequests: [UNNotificationRequest] = []
    private(set) var notifications: [UNNotification] = []

    init(center: UNUserNotificationCenter) {
        self.center = center
    }
    
    func refreshValues(completion: (() -> Void)?) {
        let group = DispatchGroup()
        dispatchGroup = group
        
        group.enter()
        center.getNotificationSettings { [weak self] (settings) in
            guard let `self` = self else { return }
            self.settings = settings
            group.leave()
        }
        
        group.enter()
        center.getNotificationCategories { [weak self] (categories) in
            guard let `self` = self else { return }
            self.categories = Array(categories)
            group.leave()
        }
        
        group.enter()
        center.getPendingNotificationRequests { [weak self] (requests) in
            guard let `self` = self else { return }
            self.pendingRequests = requests
            group.leave()
        }
        
        group.enter()
        center.getDeliveredNotifications { [weak self] (notifications) in
            guard let `self` = self else { return }
            self.notifications = notifications
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.dispatchGroup = nil
            completion?()
        }
    }
    
}
