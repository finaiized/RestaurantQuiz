//
//  ScoreTracker.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/20/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

class ScoreTracker: NSObject {
    class var sharedInstance: ScoreTracker {
        struct Static {
            static let instance = ScoreTracker()
        }
        return Static.instance
    }
    
    private var scores: [Int]
    
    private override init() {
        scores = [Int]()
    }
    
    func addScore(score: Int) {
        // TODO: Use a linked list?
        if scores.count >= 5 {
            scores.removeLast()
            
        }
    }
}
