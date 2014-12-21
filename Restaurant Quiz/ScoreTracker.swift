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
    
    private var scores: Stack<Int>
    
    private override init() {
        scores = Stack(size: 5)
    }
    
    func addScore(score: Int) {
        scores.enqueue(score)
    }
    
    func getScores() -> [Int] {
        return scores.toArray()
    }
}
