//
//  UserNotificationsViewController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UserNotifications
import UIKit

// MARK: - UserNotificationsViewController

class UserNotificationsViewController: UITableViewController {
    
    private enum Section: Int {
        case settings
        case categories
        case pendingRequests
        case notifications
    }
    
    let dataController: UserNotificationsDataController
    
    init(configuration: UserNotificationsConfiguration) {
        dataController = UserNotificationsDataController(center: configuration.notificationCenter)
        super.init(style: .plain)
        title = "User Notifications"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension UserNotificationsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        refreshData()
    }
    
    private func setupTableView() {
        tableView.debugKit_register(DebugCell.self)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
    private func refreshData() {
        dataController.refreshValues { [weak self] in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDataSource

extension UserNotificationsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let s = Section(rawValue: section) else { return 0 }
        
        switch s {
        case .settings:
            return 8
        case .categories:
            return max(1, dataController.categories.count)
        case .pendingRequests:
            return max(1, dataController.pendingRequests.count)
        case .notifications:
            return max(1, dataController.notifications.count)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let s = Section(rawValue: section) else { return nil }
        
        switch s {
        case .settings:
            return "Notification Settings"
        case .categories:
            return "Notification Categories"
        case .pendingRequests:
            return "Pending Notification Requests"
        case .notifications:
            return "Delivered Notifications"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let s = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }
        
        let cell = tableView.debugKit_dequeueReusableCell(DebugCell.self, forIndexPath: indexPath)
        cell.selectionStyle = .none
        
        switch s {
        case .settings:
            configureSettingsCell(cell, forIndexPath: indexPath)
        case .categories:
            cell.subtitleLabel.text = nil
            
            let categories = dataController.categories
            if categories.isEmpty {
                configureEmptyCell(cell)
            } else {
                let category = categories[indexPath.row]
                bindCell(cell, to: category)
            }
        case .pendingRequests:
            cell.subtitleLabel.text = nil
            
            let pendingRequests = dataController.pendingRequests
            if pendingRequests.isEmpty {
                configureEmptyCell(cell)
            } else {
                let request = pendingRequests[indexPath.row]
                bindCell(cell, to: request)
            }
        case .notifications:
            cell.subtitleLabel.text = nil
            
            let notifications = dataController.notifications
            if notifications.isEmpty {
                configureEmptyCell(cell)
            } else {
                let notification = notifications[indexPath.row]
                let request = notification.request
                bindCell(cell, to: request)
            }
        }
        
        return cell
    }
    
    private func configureSettingsCell(_ cell: DebugCell, forIndexPath indexPath: IndexPath) {
        enum SettingsRow: Int {
            case authorizationStatus
            case notificationCenterSetting
            case lockScreenSetting
            case carPlaySetting
            case alertSetting
            case alertStyle
            case badgeSetting
            case soundSetting
        }
        
        guard let settings = dataController.settings,
            let row = SettingsRow(rawValue: indexPath.row) else {
                return
        }
        
        let title: String
        let value: String?
        
        switch row {
        case .authorizationStatus:
            title = "Authorization Status"
            value = settings.authorizationStatus.title
        case .notificationCenterSetting:
            title = "Notification Center"
            value = settings.notificationCenterSetting.title
        case .lockScreenSetting:
            title = "Lock Screen"
            value = settings.lockScreenSetting.title
        case .carPlaySetting:
            title = "Car Play"
            value = settings.carPlaySetting.title
        case .alertSetting:
            title = "Alert"
            value = settings.alertSetting.title
        case .alertStyle:
            title = "Alert Style"
            value = settings.alertStyle.title
        case .badgeSetting:
            title = "Badge"
            value = settings.badgeSetting.title
        case .soundSetting:
            title = "Sound"
            value = settings.soundSetting.title
        }
        
        cell.subtitleLabel.text = title
        cell.titleLabel.text = value
        cell.accessoryType = .none
    }
    
    private func configureEmptyCell(_ cell: DebugCell) {
        cell.titleLabel.text = "None"
        cell.accessoryType = .none
        cell.selectionStyle = .none
    }
    
    private func bindCell(_ cell: DebugCell, to category: UNNotificationCategory) {
        cell.titleLabel.text = category.identifier
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
    }
    
    private func bindCell(_ cell: DebugCell, to request: UNNotificationRequest) {
        cell.subtitleLabel.text = request.identifier
        cell.titleLabel.text = request.content.body
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
    }
    
}

// MARK: - UITableViewDelegate

extension UserNotificationsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let s = Section(rawValue: indexPath.section) else { return }
        switch s {
        case .notifications:
            let note = dataController.notifications[indexPath.row]
            let request = note.request
            let requestVC = NotificationRequestViewController(request: request)
            navigationController?.pushViewController(requestVC, animated: true)
        case .pendingRequests:
            let request = dataController.pendingRequests[indexPath.row]
            let requestVC = NotificationRequestViewController(request: request)
            navigationController?.pushViewController(requestVC, animated: true)
            break
        default: break
        }
    }
    
}
