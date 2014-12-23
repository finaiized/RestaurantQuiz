//
//  Yelp.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/19/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit
import CoreLocation

class Yelp: NSObject {
    class func restaurantsFromCity(city: DDCity, category: DDCategory, completion: (restaurants: [Restaurant]) -> ()) {
        let request = TDOAuth.URLRequestForPath("/v2/search", GETParameters: ["term": "\(category.rawValue) restaurants", "location": city.rawValue], host: "api.yelp.com", consumerKey: "ZObdp8qJ-ImZZzxegBePdA", consumerSecret: "4rVrs3jq0VhVeDPhLXIIQ_x3338", accessToken: "Nwgk0--aXjyjAC4Z8SISYb8wohaXioqs", tokenSecret: "WmjZ_x2JRk-0Jiw7632BKqOlBxM")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        session.dataTaskWithRequest(request, completionHandler: {
            (data: NSData!, resp: NSURLResponse!, err: NSError!) in
            self.restaurantsFromYelpJSON(data, forCity: city, completion: completion)
        }).resume()
    }
    
    /** Given data returned from a Yelp Search request, return an array of Restaurant. Runs async. */
    class func restaurantsFromYelpJSON(data: NSData, forCity city: DDCity, completion: (restaurants: [Restaurant]) -> ()) {
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
                                let cityString = loc["city"] as String
                                let stateCode = loc["state_code"] as String
                                let country = loc["country_code"] as String
                                
                                dispatch_group_enter(group)
                                
                                let geocoder = CLGeocoder()
                                geocoder.geocodeAddressString("\(address), \(cityString), \(stateCode), \(country)", completionHandler: {
                                    (placemark: [AnyObject]!, err: NSError!) in
                                    
                                    let place = placemark[0] as CLPlacemark
                                    location = place.location.coordinate
                                    restaurants.append(Restaurant(name: name, categories: categories, location: location!, city: city))
                                    
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
