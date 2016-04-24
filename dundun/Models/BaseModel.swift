//
//  BaseModel.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

class BaseModel: NSObject {
    
    init(jsonString: String) {
        super.init()
        let json = MJson.json(jsonString)
        
        if let jsonDict = json.dictionary {
            for item in jsonDict {
                print(item.1.rawValue)
                print(item.0)
                setValue(item.1.rawValue, forKey: item.0)
            }
        }
        
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
