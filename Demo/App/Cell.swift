//
//  Cell.swift
//  Demo
//
//  Created by Xiao Yao on 10/30/18.
//  Copyright © 2018 Xiao Yao. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
    
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title2)
        contentView.addSubview(label)
        contentView.layoutMargins = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        let guide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            label.topAnchor.constraint(equalTo: guide.topAnchor),
            label.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
}
