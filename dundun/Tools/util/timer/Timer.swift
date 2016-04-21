//
//  Timer.swift
//  dundun
//
//  Created by 刘荣 on 16/4/19.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

class Timer: NSObject {
    
    class func every(interval: NSTimeInterval, target: AnyObject, selector: Selector) -> NSTimer {
        return NSTimer.scheduledTimerWithTimeInterval(interval, target: target, selector: selector, userInfo: nil, repeats: true)
    }
    
    var i = 0
    var every: (Int) -> Void
    var theEnd: () -> Void
    var timer: NSTimer?
    
    init(count: Int, every: (Int) -> Void, theEnd: () -> Void) {
        i = count
        self.every = every
        self.theEnd = theEnd
    }
    
    func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(CountdownEvent), userInfo: nil, repeats: true)
    }
    
    func CountdownEvent() {
        if i == 0 {
            timer?.invalidate()
            timer = nil
            return theEnd()
        }
        every(i)
        i -= 1
    }

}
