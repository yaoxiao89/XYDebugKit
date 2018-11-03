////
//  CLLocationManager+Utilities.swift
//  XYDebugKit
//
//  Copyright © 2018 Xiao Yao. All rights reserved.
//  See LICENSE.txt for licensing information.
//

import CoreLocation

extension CLAuthorizationStatus {
    
    var title: String {
        switch self {
        case .notDetermined:
            return "Not Determined"
        case .restricted:
            return "Restricted"
        case .denied:
            return "Denied"
        case .authorizedAlways:
            return "Authorized Always"
        case .authorizedWhenInUse:
            return "Authorized When In Use"
        }
    }
    
}
