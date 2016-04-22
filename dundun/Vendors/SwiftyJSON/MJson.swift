//
//  MJson.swift
//  dundun
//
//  Created by 刘荣 on 16/4/22.
//  Copyright © 2016年 Microali. All rights reserved.
//
import Foundation
import SwiftyJSON

class MJson {
    
    class func json(str: String) -> JSON {
        return JSON(data: str.dataUsingEncoding(NSUTF8StringEncoding)!)
    }

}
