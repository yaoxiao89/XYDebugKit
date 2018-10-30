//
//  RootViewController.swift
//  Demo
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

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

class RootViewController: UIViewController {
    
    weak var delegate: RootViewControllerDelegate?
    
}

// MARK: - View Lifecycle

extension RootViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButton()
    }
    
    private func setupButton() {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Show Debug", for: .normal)
        button.addTarget(self, action: #selector(invokeAction), for: .touchUpInside)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func invokeAction() {
        delegate?.rootViewController(self, didPerform: .debug)
    }
    
}
