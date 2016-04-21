//
//  ExtensionString.swift
//  dundun
//
//  Created by 刘荣 on 16/4/21.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

extension String {
    
    func substringFrom(index: Int) -> String {
        let str = NSString(string: self)
        return String(str.substringFromIndex(index))
    }
    
    func substringTo(index: Int) -> String {
        let str = NSString(string: self)
        return String(str.substringToIndex(index))
    }
    
    func rangeOfString(astr: String) -> NSRange {
        let str = NSString(string: self)
        return str.rangeOfString(astr)
    }
    

}
