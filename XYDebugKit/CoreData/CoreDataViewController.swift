//
//  CoreDataViewController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreData
import UIKit

// MARK: - CoreDataViewController

class CoreDataViewController: UITableViewController {
    
    let dataController: CoreDataDataController
    
    init(configuration: CoreDataDebugConfiguration) {
        let container = configuration.container
        dataController = CoreDataDataController(container: container)
        super.init(style: .plain)
        title = container.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension CoreDataViewController {
    
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

// MARK: - ManagedObjectViewControllerDelegate

extension CoreDataViewController: ManagedObjectViewControllerDelegate {
    
    func managedObjectViewController(_ viewController: ManagedObjectViewController, didPerform action: ManagedObjectViewControllerAction) {
        switch action {
        case .select(let mo):
            presentManagedObjectsViewController(for: mo.entity)
        }
    }
    
}

// MARK: - ManagedObjectsViewControllerDelegate

extension CoreDataViewController: ManagedObjectsViewControllerDelegate {
    
    func managedObjectsViewController(_ viewController: ManagedObjectsViewController, didPerform action: ManagedObjectsViewControllerAction) {
        switch action {
        case .select(let mo):
            let moVC = ManagedObjectViewController(managedObject: mo, container: dataController.container)
            moVC.managedObjectDelegate = self
            navigationController?.pushViewController(moVC, animated: true)
        }
    }
    
}

// MARK: - UITableViewController

extension CoreDataViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.entities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DebugCell.self, forIndexPath: indexPath)
        let entity = dataController.value(at: indexPath)
        bindCell(cell, to: entity)
        return cell
    }
    
    private func bindCell(_ cell: DebugCell, to entity: CoreDataEntity) {
        cell.titleLabel.text = "\(entity.name ?? ""): \(entity.count)"
        cell.subtitleLabel.text = nil
        cell.accessoryType = .disclosureIndicator
    }
    
}

// MARK: - UITableViewDelegate

extension CoreDataViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let entity = dataController.value(at: indexPath)
        presentManagedObjectsViewController(for: entity.entity)
    }
    
    private func presentManagedObjectsViewController(for entity: NSEntityDescription) {
        let mosVC = ManagedObjectsViewController(entity: entity, container: dataController.container)
        mosVC.managedObjectsDelegate = self
        navigationController?.pushViewController(mosVC, animated: true)
    }
    
}
