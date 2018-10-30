//
//  NotificationRequestViewController.swift
//  XYDebugKit
//
//  Created by Xiao Yao on 10/30/18.
//  Copyright © 2018 Xiao Yao. All rights reserved.
//

import UserNotifications
import UIKit

// MARK: - NotificationRequestViewController

class NotificationRequestViewController: UITableViewController {
    
    private enum Section: Int {
        case identifier
        case content
        case trigger
    }
    
    let dataController: NotificationRequestDataController
    private let request: UNNotificationRequest
    
    init(request: UNNotificationRequest) {
        dataController = NotificationRequestDataController(request: request)
        self.request = request
        super.init(style: .plain)
        title = "Notification Request"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension NotificationRequestViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DebugCell.self)
    }
    
}

// MARK: - UITableViewDataSource

extension NotificationRequestViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let s = Section(rawValue: section) else { return 0 }
        switch s {
        case .identifier:
            return 1
        case .content:
            return 10
        case .trigger:
            if let trigger = request.trigger {
                if trigger is UNCalendarNotificationTrigger {
                    return 3
                } else {
                    return 1
                }
            } else {
                return 0
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(DebugCell.self, forIndexPath: indexPath)
        
        switch section {
        case .identifier:
            cell.subtitleLabel.text = nil
            cell.titleLabel.text = request.identifier
        case .content:
            configureContentCell(cell, at: indexPath)
        case .trigger:
            configureTriggerCell(cell, at: indexPath)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let s = Section(rawValue: section) else { return nil }
        switch s {
        case .identifier:
            return "Identifier"
        case .content:
            return "Content"
        case .trigger:
            return "Trigger"
        }
    }
    
    private func configureContentCell(_ cell: DebugCell, at indexPath: IndexPath) {
        cell.titleLabel.text = dataController.contentTitle(at: indexPath)
        cell.subtitleLabel.text = dataController.contentSubtitle(at: indexPath)
    }
    
    private func configureTriggerCell(_ cell: DebugCell, at indexPath: IndexPath) {
        guard let trigger = request.trigger else {
            cell.subtitleLabel.text = nil
            cell.titleLabel.text = nil
            return
        }
        
        let row = indexPath.row
        if row == 0 {
            cell.subtitleLabel.text = "Repeats"
            cell.titleLabel.text = trigger.repeats ? "Yes" : "No"
        } else {
            if let calendarTrigger = trigger as? UNCalendarNotificationTrigger {
                if row == 1 {
                    cell.subtitleLabel.text = "Next Trigger Date"
                    if let date = calendarTrigger.nextTriggerDate() {
                        cell.titleLabel.text = String(describing: date)
                    } else {
                        cell.titleLabel.text = "-"
                    }
                } else {
                    cell.subtitleLabel.text = "Date Components"
                    cell.titleLabel.text = String(describing: calendarTrigger.dateComponents)
                }
            }
        }
    }
    
}

