//
//  LocationDataController.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreLocation

// MARK: - LocationDataController

class LocationDataController {
    
    private let manager: CLLocationManager
    
    let values: [DebugValue]
    
    init(manager: CLLocationManager) {
        self.manager = manager
        
        let statusValue = DebugValue(title: "Authorization Status", value: CLLocationManager.authorizationStatus().title)
        let enabledValue = DebugValue(title: "Services Enabled", value: CLLocationManager.locationServicesEnabled().stringValue)
        let deferredValue = DebugValue(title: "Deferred Updates Available", value: CLLocationManager.deferredLocationUpdatesAvailable().stringValue)
        let headingValue = DebugValue(title: "Heading Available", value: CLLocationManager.headingAvailable().stringValue)
        let rangingValue = DebugValue(title: "Ranging Available", value: CLLocationManager.isRangingAvailable().stringValue)
        values = [statusValue, enabledValue, deferredValue, headingValue, rangingValue]
    }
        
}

// MARK: - Bool

extension Bool {
    
    var stringValue: String {
        return self == true ? "Yes" : "No"
    }
    
}
