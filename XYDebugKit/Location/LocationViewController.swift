//
//  LocationViewController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UIKit

// MARK: - LocationViewController

class LocationViewController: UITableViewController {
    
    let dataController: LocationDataController
    
    init(configuration: LocationConfiguration) {
        dataController = LocationDataController(manager: configuration.manager)
        super.init(style: .plain)
        title = "Location"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension LocationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.debugKit_register(DebugCell.self)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
    }
    
}

// MARK: - UITableViewDataSource

extension LocationViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.values.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.debugKit_dequeueReusableCell(DebugCell.self, forIndexPath: indexPath)
        let value = dataController.values[indexPath.row]
        bindCell(cell, to: value)
        return cell
    }
    
    private func bindCell(_ cell: DebugCell, to value: DebugValue) {
        cell.subtitleLabel.text = value.title
        cell.titleLabel.text = value.value
    }
    
}
