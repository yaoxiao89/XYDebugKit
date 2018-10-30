//
//  DirectoryDataController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import Foundation

class DirectoryDataController {
    
    let urls: [URL]
    
    init(url: URL, fileManager: FileManager = .default) {
        do {
            urls = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: [])
        } catch {
            urls = []
        }
    }
    
}
