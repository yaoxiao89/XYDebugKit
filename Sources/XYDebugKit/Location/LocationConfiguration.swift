//
//  LocationConfiguration.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreLocation

public struct LocationConfiguration: DebugConfiguration {
    
    public var type: DebugConfigurationType = .location
    
    let manager: CLLocationManager
    
    public init(manager: CLLocationManager) {
        self.manager = manager
    }
    
}
