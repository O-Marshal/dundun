//
//  WalletList.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletList: BaseModel {
   
    var type:String?
    var title:String?
    var desc:String?
    var money:CFloat?
    var time:String?
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        print("没有这个属性: \(key)")
    }

    
    class func defaultWalletList(jsonListString:String) -> Array<WalletList> {
        let json = MJson.json(jsonListString)
        var resultList:Array<WalletList> = []
        if let jsonList = json.array {
            for jsonItem in jsonList {
              print(jsonItem.dictionary)
              let item = WalletList(jsonString: jsonItem.string!)
                resultList.append(item)
            }
        }
        return resultList
    
    }
}
