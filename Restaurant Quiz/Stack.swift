//
//  Queue.swift
//  Restaurant Quiz
//
//  Created by Dominic Kuang on 12/20/14.
//  Copyright (c) 2014 Dominic Kuang. All rights reserved.
//

import UIKit

public class Stack<T: Equatable> {
    var array: [T?]
    var count: Int = 0
    var back: Int = 1
    let size: Int
    
    init(size: Int) {
        array = [T?](count: size, repeatedValue: nil)
        self.size = size
    }
    
    func enqueue(item: T) {
        array[back] = item
        back = (back + 1) % size
        count++
    }
    
    func dequeue() -> T? {
        var index = (back - 1) % size
        if index < 0 {
            index = size - 1
        }
        
        let val = array[index]
        back = index
        count--
        return val
    }
    
    func toArray() -> [T] {
        var temp = [T]()
        for i in 0..<size {
            let k = dequeue()
            NSLog("\(k)")
            if let k = k {
                temp.append(k)
            }
        }
        return temp
    }
}