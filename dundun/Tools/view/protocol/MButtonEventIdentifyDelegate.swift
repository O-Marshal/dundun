//
//  MButtonEventIdentifyDelegate.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

protocol MButtonEventIdentifyDelegate {
    func onTouchEvent(identify: String?)
    func onTouchEvent(identify: String?, index: Int)
}
