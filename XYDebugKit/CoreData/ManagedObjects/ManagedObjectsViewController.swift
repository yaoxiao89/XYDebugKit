//
//  ManagedObjectsViewController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreData
import UIKit

// MARK: - ManagedObjectsViewControllerAction

enum ManagedObjectsViewControllerAction {
    case select(NSManagedObject)
}

// MARK: - ManagedObjectsViewControllerDelegate

protocol ManagedObjectsViewControllerDelegate: AnyObject {
    
    func managedObjectsViewController(_ viewController: ManagedObjectsViewController, didPerform action: ManagedObjectsViewControllerAction)
    
}

// MARK: - ManagedObjectsViewController

class ManagedObjectsViewController: UITableViewController {
    
    weak var managedObjectsDelegate: ManagedObjectsViewControllerDelegate?
    
    let dataController: ManagedObjectsDataController
    
    init(entity: NSEntityDescription, container: NSPersistentContainer) {
        dataController = ManagedObjectsDataController(entity: entity, container: container)
        super.init(style: .plain)
        title = entity.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension ManagedObjectsViewController {
    
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

extension ManagedObjectsViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.managedObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DebugCell.self, forIndexPath: indexPath)
        let mo = dataController.managedObjects[indexPath.row]
        bindCell(cell, to: mo)
        return cell
    }
    
    private func bindCell(_ cell: DebugCell, to managedObject: NSManagedObject) {
        cell.titleLabel.text = managedObject.attributesDescription()
        cell.subtitleLabel.text = nil
        cell.accessoryType = .disclosureIndicator
    }
    
}

// MARK: - UITableViewDelegate

extension ManagedObjectsViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let mo = dataController.value(at: indexPath)
        managedObjectsDelegate?.managedObjectsViewController(self, didPerform: .select(mo))
    }
    
}
