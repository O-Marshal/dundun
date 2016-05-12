//
//  ExtensionWithNumbers.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

extension Float {
    
    var cfloatValue: CGFloat {
        return CGFloat(self)
    }
    
    var dobuleValue: Double {
        return Double(self)
    }
    
    var intValue: Int {
        return Int(self)
    }
}

extension Int {
    
    var floatValue: Int {
        return Int(self)
    }
    
    var cfloatValue: CGFloat {
        return CGFloat(self)
    }
    
    var dobuleValue: Double {
        return Double(self)
    }
}