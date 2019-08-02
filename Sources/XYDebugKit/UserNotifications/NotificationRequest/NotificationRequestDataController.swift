//
//  NotificationRequestDataController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UserNotifications

class NotificationRequestDataController {
    
    let request: UNNotificationRequest
    
    init(request: UNNotificationRequest) {
        self.request = request
    }
    
    func contentTitle(at indexPath: IndexPath) -> String? {
        let content = request.content
        switch indexPath.row {
        case 0:
            return content.title.isEmpty ? "-" : content.title
        case 1:
            return content.subtitle.isEmpty ? "-" : content.subtitle
        case 2:
            return content.body.isEmpty ? "-" : content.body
        case 3:
            if let badge = content.badge {
                return String(describing: badge)
            } else {
                return "-"
            }
        case 4:
            if let sound = content.sound {
                return String(describing: sound)
            } else {
                return "-"
            }
        case 5:
            return content.launchImageName.isEmpty ? "-" : content.launchImageName
        case 6:
            return content.userInfo.isEmpty ? "-" : String(describing: content.userInfo)
        case 7:
            return content.attachments.isEmpty ? "-" : String(describing: content.attachments)
        case 8:
            return content.categoryIdentifier.isEmpty ? "-" : content.categoryIdentifier
        case 9:
            return content.threadIdentifier.isEmpty ? "-" : content.threadIdentifier
        default:
            return nil
        }
    }
    
    func contentSubtitle(at indexPath: IndexPath) -> String? {
        switch indexPath.row {
        case 0:
            return "Title"
        case 1:
            return "Subtitle"
        case 2:
            return "Body"
        case 3:
            return "Badge"
        case 4:
            return "Sound"
        case 5:
            return "Launch Image Name"
        case 6:
            return "User Info"
        case 7:
            return "Attachments"
        case 8:
            return "Category ID"
        case 9:
            return "Thread ID"
        default:
            return nil
        }
    }
    
}
