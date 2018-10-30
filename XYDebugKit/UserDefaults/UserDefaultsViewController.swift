//
//  UserDefaultsViewController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UIKit

// MARK: - UserDefaultsViewController

class UserDefaultsViewController: UITableViewController {
    
    let dataController: UserDefaultsDataController
    
    init(configuration: UserDefaultsDebugConfiguration) {
        dataController = UserDefaultsDataController(configuration: configuration)
        super.init(style: .plain)
        title = configuration.suiteName
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension UserDefaultsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(DebugCell.self)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
}

// MARK: - UITableViewDataSource

extension UserDefaultsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DebugCell.self, forIndexPath: indexPath)
        let key = dataController.keys[indexPath.row]
        bindCell(cell, to: key)
        return cell
    }
    
    private func bindCell(_ debugCell: DebugCell, to key: String) {
        debugCell.subtitleLabel.text = key
        debugCell.titleLabel.text = dataController.value(forKey: key)
    }
    
}
