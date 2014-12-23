//
//  Restaurant.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/19/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit
import CoreLocation

struct Restaurant {
    var name: String
    var categories: [String]
    var coordinate: CLLocationCoordinate2D
    var city: DDCity
    
    var description: String {
        return "\(name) includes category \(categories[0]) at \(coordinate.latitude), \(coordinate.longitude)"
    }
    
    init(name: String, categories: [String], location: CLLocationCoordinate2D, city: DDCity) {
        self.name = name
        self.categories = categories
        self.coordinate = location
        self.city = city
    }
}
