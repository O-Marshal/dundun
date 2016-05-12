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
    
    func split(separator: String) -> [String] {
        return self.componentsSeparatedByString(separator)
    }
    
    func sizeWithFont(font: UIFont?) -> CGSize {
        return NSString(string: self).sizeWithAttributes([NSFontAttributeName: font!])
    }
    
    func size(font: UIFont?, size: CGSize) -> CGSize {
        let str = NSString(string: self)
        return str.boundingRectWithSize(size, options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font!], context: nil).size
    }
    

}
