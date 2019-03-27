//
//  DebugConfigurationsViewController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UIKit
import os.log

// MARK: - DebugConfigurationsViewControllerAction

enum DebugConfigurationsViewControllerAction {
    case select(DebugConfiguration)
}

// MARK: - DebugConfigurationsViewControllerDelegate

protocol DebugConfigurationsViewControllerDelegate: AnyObject {
    
    func debugConfigurationsViewController(_ viewController: DebugConfigurationsViewController, didPerform action: DebugConfigurationsViewControllerAction)
    
}

// MARK: - DebugConfigurationsViewController

class DebugConfigurationsViewController: UITableViewController {
    
    weak var configurationsDelegate: DebugConfigurationsViewControllerDelegate?
    let configurations: [DebugConfiguration]
    
    init(configurations: [DebugConfiguration]) {
        self.configurations = configurations
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension DebugConfigurationsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.register(DebugCell.self)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
}

// MARK: - UITableViewDataSource

extension DebugConfigurationsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configurations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DebugCell.self, forIndexPath: indexPath)
        let config = configurations[indexPath.row]
        bindCell(cell, to: config)
        return cell
    }
    
    func bindCell(_ cell: DebugCell, to configuration: DebugConfiguration) {
        cell.accessoryType = .disclosureIndicator
        cell.subtitleLabel.text = configuration.type.displayName
        switch configuration {
        case let config as UserDefaultsDebugConfiguration:
            let suiteName = config.suiteName
            cell.titleLabel.text = suiteName
        case let config as DirectoryDebugConfiguration:
            cell.titleLabel.text = config.url.absoluteString
        case let config as CoreDataDebugConfiguration:
            cell.titleLabel.text = config.container.name
        case _ as UserNotificationsConfiguration:
            cell.titleLabel.text = "Current"
        case _ as LocationConfiguration:
            cell.titleLabel.text = "Location"
        default:
            os_log("Unsupported debug configuration: %@", String(describing: configuration))
        }
    }
    
}

// MARK: - UITableViewDelegate

extension DebugConfigurationsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let config = configurations[indexPath.row]
        configurationsDelegate?.debugConfigurationsViewController(self, didPerform: .select(config))
    }
    
}
