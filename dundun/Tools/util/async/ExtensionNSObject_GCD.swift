//
//  ExtensionNSObject_GCD.swift
//  dundun
//
//  Created by 刘荣 on 16/4/17.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

extension NSObject {
    
    /**
     主线程事件
     */
    func async_main(void: ()->Void) {
        dispatch_async(dispatch_get_main_queue(), void)
    }
    
    /**
     同步队列
     */
    func sync_queue(label: String, void: ()->Void) {
        dispatch_sync(dispatch_queue_create(label, nil), void)
    }
    
    /**
     异步队列
     */
    func async_queue(label: String, void: ()->Void) {
        dispatch_async(dispatch_queue_create(label, nil), void)
    }
    
    func async_queue_after(time: Int, label: String, void: ()->Void) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time)), dispatch_queue_create(label, nil), void)
    }
    
    func async_main_after(time: Int, void: ()->Void) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(time)), dispatch_get_main_queue(), void)
    }
    
}
