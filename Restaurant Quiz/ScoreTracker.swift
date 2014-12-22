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
    private var attempts: Stack<Int>
    
    private override init() {
        scores = Stack(size: 5)
        attempts = Stack(size: 5)
    }
    
    func addScore(score: Int, attempts: Int) {
        scores.enqueue(score)
        self.attempts.enqueue(attempts)
    }
    
    func getScores() -> [Int] {
        return scores.toArray()
    }
    
    func getAttempts() -> [Int] {
        return attempts.toArray()
    }
    
    func highestScore() -> Int {
        var highestScore:Int = 0
        for score in getScores() {
            if score > highestScore {
                highestScore = score
            }
        }
        return highestScore
    }
    
    func minimumAttempts() -> Int {
        var minAttempts = Int(INT_MAX)
        for attempt in getAttempts() {
            if attempt < minAttempts {
                minAttempts = attempt
            }
        }
        return minAttempts
    }
}
