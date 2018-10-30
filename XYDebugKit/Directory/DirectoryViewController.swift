//
//  DirectoryViewController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UIKit

// MARK: - DirectoryViewController

class DirectoryViewController: UITableViewController {
    
    private let dataController: DirectoryDataController
    
    init(url: URL) {
        dataController = DirectoryDataController(url: url)
        super.init(style: .plain)
        title = url.absoluteString
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension DirectoryViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.register(DebugCell.self)
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
    }
    
}

// MARK: - UITableViewDataSource

extension DirectoryViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.urls.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DebugCell.self, forIndexPath: indexPath)
        let key = dataController.urls[indexPath.row]
        bindCell(cell, to: key)
        return cell
    }
    
    private func bindCell(_ debugCell: DebugCell, to url: URL) {
        debugCell.subtitleLabel.text = nil
        debugCell.titleLabel.text = url.absoluteString
        debugCell.accessoryType = .disclosureIndicator
    }
    
}

// MARK: - UITableViewDelegate

extension DirectoryViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let url = dataController.urls[indexPath.row]
        let directoryVC = DirectoryViewController(url: url)
        navigationController?.pushViewController(directoryVC, animated: true)
    }
    
}
