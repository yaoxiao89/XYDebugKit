//
//  DebugViewController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UIKit
import os.log

// MARK: - DebugViewControllerAction

public enum DebugViewControllerAction {
    case dismiss
}

// MARK: - DebugViewControllerDelegate

public protocol DebugViewControllerDelegate: AnyObject {
    
    func debugViewController(_ viewController: DebugViewController, didPerform action: DebugViewControllerAction)
    
}

// MARK: - DebugViewController

public class DebugViewController: UIViewController {
    
    public weak var delegate: DebugViewControllerDelegate?
    let contentViewController: UINavigationController
    
    public init(configurations: [DebugConfiguration]) {
        let configsVC = DebugConfigurationsViewController(configurations: configurations)
        let navController = UINavigationController(rootViewController: configsVC)
        contentViewController = navController
        
        super.init(nibName: nil, bundle: nil)
        
        navController.navigationBar.prefersLargeTitles = true
        configsVC.title = "Debugger"
        
        configsVC.configurationsDelegate = self
        configsVC.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissDebugViewController))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissDebugViewController() {
        delegate?.debugViewController(self, didPerform: .dismiss)
    }
    
}

// MARK: - View Lifecycle

extension DebugViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupContentViewController()
    }
    
    func setupContentViewController() {
        addChild(contentViewController)
        contentViewController.view.pinToViewController(self)
        contentViewController.didMove(toParent: self)
    }
    
}

// MARK: - DebugConfigurationsViewControllerDelegate

extension DebugViewController: DebugConfigurationsViewControllerDelegate {
    
    func debugConfigurationsViewController(_ viewController: DebugConfigurationsViewController, didPerform action: DebugConfigurationsViewControllerAction) {
        switch action {
        case .select(let configuration):
            presentViewController(for: configuration)
        }
    }
    
    func presentViewController(for configuration: DebugConfiguration) {
        switch configuration {
        case let config as UserDefaultsDebugConfiguration:
            let userDefaultsVC = UserDefaultsViewController(configuration: config)
            contentViewController.pushViewController(userDefaultsVC, animated: true)
        case let config as DirectoryDebugConfiguration:
            let directoryVC = DirectoryViewController(url: config.url)
            contentViewController.pushViewController(directoryVC, animated: true)
        case let config as CoreDataDebugConfiguration:
            let coreDataVC = CoreDataViewController(configuration: config)
            contentViewController.pushViewController(coreDataVC, animated: true)
        case let config as UserNotificationsConfiguration:
            let notificationsVC = UserNotificationsViewController(configuration: config)
            contentViewController.pushViewController(notificationsVC, animated: true)
        default:
            os_log("Unsupported debug configuration: %@", String(describing: configuration))
        }
    }
    
}
