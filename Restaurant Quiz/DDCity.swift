
//
//  DDCity.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/17/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit
import MapKit

enum DDCity: String {
    case Vancouver = "Vancouver, B.C."
    case Edmonton = "Edmonton, AB"
    
    static let allValues = [Vancouver, Edmonton]
    
    func regionFromCity() -> MKCoordinateRegion {
        switch self {
        case .Vancouver:
            return MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 49.236835, longitude: -123.034162), 30000, 30000)
        case .Edmonton:
            return MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2D(latitude: 53.533, longitude: -113.5), 55000, 55000)
        }
    }
    
}
