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
    
    var description: String {
        return "\(name) includes category \(categories[0]) at \(coordinate.latitude), \(coordinate.longitude)"
    }
    
    init(name: String, categories: [String], location: CLLocationCoordinate2D) {
        self.name = name
        self.categories = categories
        self.coordinate = location
    }
    
    /** Given data returned from a Yelp Search request, return an array of Restaurant. Runs async. */
    static func restaurantsFromYelpJSON(data: NSData, completion: (restaurants: [Restaurant]) -> ()) {
        var restaurants = [Restaurant]()
        let group = dispatch_group_create()
        
        // Parse Yelp JSON
        if let businessDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.allZeros, error: nil) as? NSDictionary {
            if let businessArray = businessDictionary["businesses"] as? NSArray {
                for i in businessArray {
                    if let business = i as? NSDictionary {
                        let name = business["name"] as String
                        
                        var categories = [String]()
                        if let categoryDictionaries = business["categories"] as? NSArray {
                            for category in categoryDictionaries {
                                categories.append(category[0] as String)
                            }
                        }
                        
                        var location: CLLocationCoordinate2D?
                        if let loc = business["location"] as? NSDictionary {
                            if let a = loc["address"] as? NSArray {
                                let address = a[0] as String
                                let city = loc["city"] as String
                                let stateCode = loc["state_code"] as String
                                let country = loc["country_code"] as String
                                
                                dispatch_group_enter(group)
                                
                                let geocoder = CLGeocoder()
                                geocoder.geocodeAddressString("\(address), \(city), \(stateCode), \(country)", completionHandler: {
                                    (placemark: [AnyObject]!, err: NSError!) in
                                    
                                    let place = placemark[0] as CLPlacemark
                                    location = place.location.coordinate
                                    restaurants.append(Restaurant(name: name, categories: categories, location: location!))
                                    
                                    dispatch_group_leave(group)
                                })
                            }
                        }
                    }
                }
            }
        }
        // This will be called only after all code surrounded by dispatch_group_enter and dispatch_group_leave has been executed
        dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            completion(restaurants: restaurants)
        })
        
    }
}
