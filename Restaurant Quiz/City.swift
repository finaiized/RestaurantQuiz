
//
//  City.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/17/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit
import MapKit

enum City: String {
    case Vancouver = "Vancouver, B.C."
    case Edmonton = "Edmonton, AB"
    
    static let allValues = [Vancouver, Edmonton]
    
    /** Returns a region encompassing the city */
    func regionFromCity() -> MKCoordinateRegion {
        switch self {
        case .Vancouver:
            return MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 49.236835, longitude: -123.034162), 30000, 30000)
        case .Edmonton:
            return MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 53.533, longitude: -113.5), 55000, 55000)
        }
    }
    
    /** Returns a camera centered at the city */
    func cameraFromCity() -> MKMapCamera {
        switch self {
        case .Vancouver:
            return MKMapCamera(lookingAtCenterCoordinate: CLLocationCoordinate2D(latitude: 49.256642129388, longitude: -123.149162503575), fromEyeCoordinate: CLLocationCoordinate2D(latitude: 49.256642129388, longitude: -123.149162503575), eyeAltitude: 37950.223108791)
        case .Edmonton:
            return MKMapCamera(lookingAtCenterCoordinate: CLLocationCoordinate2D(latitude: 53.5485265687161, longitude: -113.51173019142), fromEyeCoordinate: CLLocationCoordinate2D(latitude: 53.5485265687161, longitude: -113.51173019142), eyeAltitude: 61870.4060845252)
        }
    }
}
