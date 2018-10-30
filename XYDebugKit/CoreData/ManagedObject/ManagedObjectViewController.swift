//
//  ManagedObjectViewController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreData
import UIKit

// MARK: - ManagedObjectViewControllerAction

enum ManagedObjectViewControllerAction {
    case select(NSManagedObject)
}

// MARK: - ManagedObjectViewControllerDelegate

protocol ManagedObjectViewControllerDelegate: AnyObject {
    
    func managedObjectViewController(_ viewController: ManagedObjectViewController, didPerform action: ManagedObjectViewControllerAction)
    
}

// MARK: - ManagedObjectViewController

class ManagedObjectViewController: UITableViewController {
    
    weak var managedObjectDelegate: ManagedObjectViewControllerDelegate?
    
    let dataController: ManagedObjectDataController
    
    init(managedObject: NSManagedObject, container: NSPersistentContainer) {
        dataController = ManagedObjectDataController(managedObject: managedObject, container: container)
        super.init(style: .plain)
        title = managedObject.entity.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - View Lifecycle

extension ManagedObjectViewController {
    
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

extension ManagedObjectViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return dataController.relationships.count + 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return dataController.attributes.count
        }
        let relationship = getRelationship(for: section)
        return relationship.managedObjects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DebugCell.self, forIndexPath: indexPath)
        
        cell.subtitleLabel.text = nil
        
        let section = indexPath.section
        if section == 0 {
            let attribute = dataController.attributes[indexPath.row]
            bindCell(cell, to: attribute)
        } else {
            let relationship = getRelationship(for: section)
            let mo = relationship.managedObjects[indexPath.row]
            bindCell(cell, to: mo)
        }
        
        return cell
    }
    
    private func bindCell(_ cell: DebugCell, to attribute: Attribute) {
        cell.titleLabel.text = "\(attribute.name): \(attribute.value)"
        cell.accessoryType = .none
        cell.selectionStyle = .none
    }
    
    private func bindCell(_ cell: DebugCell, to managedObject: NSManagedObject) {
        cell.titleLabel.text = managedObject.attributesDescription()
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .default
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Attributes"
        }
        
        let relationship = getRelationship(for: section)
        return "Relationship: \(relationship.name)"
    }
    
    func getRelationship(for section: Int) -> Relationship {
        return dataController.relationships[section - 1]
    }
    
}

// MARK: - UITableViewDelegate

extension ManagedObjectViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let section = indexPath.section
        if section > 0 {
            let relationship = getRelationship(for: section)
            let mo = relationship.managedObjects[indexPath.row]
            managedObjectDelegate?.managedObjectViewController(self, didPerform: .select(mo))
        }
    }
    
}
