//
//  PersonalModel.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

class PersonalModel: BaseModel {
    
    var nick: String?
    var header: String?
    var sex = 0
    var vali: PersonalValidateModel?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        if key == "validate" {
            vali = PersonalValidateModel()
            if let dict = value {
                if dict.isKindOfClass(NSDictionary.classForCoder()) {
                    vali?.setValuesForKeysWithDictionary(dict as! [String : AnyObject])
                }
            }
        }
    }

}
