//
//  AppCoordinator.swift
//  Demo
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreData
import CoreLocation
import UserNotifications
import UIKit
import XYDebugKit
import os.log

// MARK: - AppCoordinator

class AppCoordinator {
    
    let rootViewController: UIViewController
    
    init() {
        let rootVC = RootViewController()
        let navController = UINavigationController(rootViewController: rootVC)
        navController.navigationBar.prefersLargeTitles = true
        rootViewController = navController
        rootVC.delegate = self
    }
    
}

// MARK: - DebugViewControllerDelegate

extension AppCoordinator: DebugViewControllerDelegate {
    
    func debugViewController(_ viewController: DebugViewController, didPerform action: DebugViewControllerAction) {
        switch action {
        case .dismiss:
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}

// MARK: - RootViewControllerDelegate

extension AppCoordinator: RootViewControllerDelegate {
    
    func rootViewController(_ viewController: RootViewController, didPerform action: RootViewControllerAction) {
        switch action {
        case .debug:
            let directoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
            let container = NSPersistentContainer(name: "Database")
            container.loadPersistentStores { (description, error) in
                if let err = error {
                    os_log("CoreData Error: %@", err.localizedDescription)
                } else {
                    let context = container.viewContext
                    let request: NSFetchRequest<List> = List.fetchRequest()
                    do {
                        let lists = try context.fetch(request)
                        if lists.isEmpty {
                            let list = List(context: context)
                            list.title = "Todos"
                            
                            var listItem = ListItem(context: context)
                            listItem.title = "Pack Lunches"
                            listItem.list = list
                            
                            listItem = ListItem(context: context)
                            listItem.title = "Workout"
                            listItem.list = list
                            
                            listItem = ListItem(context: context)
                            listItem.title = "Take Out Trash"
                            listItem.list = list
                            
                            try context.save()
                        }
                    } catch {
                        os_log("CoreData Error: %@", error.localizedDescription)
                    }
                }
            }
            
            let debugVC = DebugViewController(configurations: [
                UserDefaultsDebugConfiguration(userDefaults: UserDefaults.standard, suiteName: nil),
                DirectoryDebugConfiguration(url: directoryURL),
                CoreDataDebugConfiguration(container: container),
                UserNotificationsConfiguration(notificationCenter: UNUserNotificationCenter.current()),
                LocationConfiguration(manager: CLLocationManager())
            ])
            debugVC.delegate = self
            rootViewController.present(debugVC, animated: true, completion: nil)
        }
    }
    
}
