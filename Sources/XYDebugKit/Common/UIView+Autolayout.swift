//
//  UIView+Autolayout.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import UIKit

extension UIView {
    
    func debugKit_pinToViewController(_ viewController: UIViewController) {
        translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(self)
        
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
            trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
            topAnchor.constraint(equalTo: viewController.view.topAnchor),
            bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor),
        ])
    }
    
    func debugKit_pinToLayoutGuide(_ guide: UILayoutGuide) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            topAnchor.constraint(equalTo: guide.topAnchor),
            bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
}
