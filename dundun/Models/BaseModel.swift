//
//  BaseModel.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

class BaseModel: NSObject {
    
    override init() {
        super.init()
    }
    
    init(jsonString: String) {
        super.init()
        let dict = try! NSJSONSerialization.JSONObjectWithData(jsonString.dataUsingEncoding(NSUTF8StringEncoding)!, options: .MutableContainers)
        setValuesForKeysWithDictionary(dict as! [String : AnyObject])
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("没有这个属性: \(key)")
    }
    
    override var description: String {
        var str = ""
        for item in Mirror(reflecting: self).children {
            str +=  "\(item.label!):\(item.value);"
        }
        return str
    }
    

}
