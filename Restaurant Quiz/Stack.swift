//
//  Queue.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/20/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

public class Stack: NSObject, NSCoding {
    var array: [NSNumber?]
    var count: Int = 0
    var back: Int = 1
    let size: Int
    
    init(size: Int) {
        array = [NSNumber?](count: size, repeatedValue: nil)
        self.size = size
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.size = aDecoder.decodeIntegerForKey("size")
        array = [NSNumber?](count: size, repeatedValue: nil)
        let tempArray = aDecoder.decodeObjectForKey("array") as [NSNumber]
        self.count = tempArray.count
        self.back = self.count
        
        for i in 0..<tempArray.count {
            array[i] = tempArray[i]
        }
    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeInteger(size, forKey: "size")
        aCoder.encodeObject(toArray().reverse(), forKey: "array")
    }
    
    func enqueue(item: NSNumber) {
        array[back] = item
        back = (back + 1) % size
        count++
    }
    
    func dequeue() -> NSNumber? {
        var index = (back - 1) % size
        if index < 0 {
            index = size - 1
        }
        
        let val = array[index]
        back = index
        count--
        return val
    }
    
    func toArray() -> [NSNumber] {
        var temp = [NSNumber]()
        for i in 0..<size {
            let k = dequeue()
            if let k = k {
                temp.append(k)
            }
        }
        return temp
    }
}
