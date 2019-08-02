//
//  DirectoryDebugConfiguration.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import Foundation

public class DirectoryDebugConfiguration: DebugConfiguration {
    
    public var type: DebugConfigurationType = .directory
    
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
}
