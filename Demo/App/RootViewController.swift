//
//  RootViewController.swift
//  Demo
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UserNotifications
import UIKit

// MARK: - RootViewControllerAction

enum RootViewControllerAction {
    case debug
}

// MARK: - RootViewControllerDelegate

protocol RootViewControllerDelegate: AnyObject {
    
    func rootViewController(_ viewController: RootViewController, didPerform action: RootViewControllerAction)
    
}

// MARK: - RootViewController

class RootViewController: UITableViewController {
    
    enum Row: Int, CaseIterable {
        case debug
        case addNotification
    }
    
    weak var delegate: RootViewControllerDelegate?
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
}

// MARK: - View Lifecycle

extension RootViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "XYDebugKit Demo"
        view.backgroundColor = .white
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(Cell.self)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
}

// MARK: - UITableViewDataSource

extension RootViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let row = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(Cell.self, forIndexPath: indexPath)
        switch row {
        case .debug:
            cell.label.text = "Show Debug"
        case .addNotification:
            cell.label.text = "Add Reminder"
        }
        
        return cell
    }
    
}

// MARK: -

extension RootViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let row = Row(rawValue: indexPath.row) else { return }
        switch row {
        case .debug:
            delegate?.rootViewController(self, didPerform: .debug)
        case .addNotification:
            let snoozeDate = Date().addingTimeInterval(60.0)
            let calendar = Calendar.autoupdatingCurrent
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: snoozeDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = "Hello World!"
            content.sound = UNNotificationSound.default
            content.categoryIdentifier = "com.debugkit.demo"
            
            let request = UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )
            notificationCenter.add(request, withCompletionHandler: nil)
        }
    }
    
}
