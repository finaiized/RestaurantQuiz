//
//  Yelp.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/19/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class Yelp: NSObject {
    class func restaurantsFromCity(city: DDCity, completion: (data: NSData) -> ()) {
        let request = TDOAuth.URLRequestForPath("/v2/search", GETParameters: ["term": "restaurants", "location": city.rawValue], host: "api.yelp.com", consumerKey: "ZObdp8qJ-ImZZzxegBePdA", consumerSecret: "4rVrs3jq0VhVeDPhLXIIQ_x3338", accessToken: "Nwgk0--aXjyjAC4Z8SISYb8wohaXioqs", tokenSecret: "WmjZ_x2JRk-0Jiw7632BKqOlBxM")
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        session.dataTaskWithRequest(request, completionHandler: {
            (data: NSData!, resp: NSURLResponse!, err: NSError!) in
            completion(data: data)
        }).resume()
    }
}
