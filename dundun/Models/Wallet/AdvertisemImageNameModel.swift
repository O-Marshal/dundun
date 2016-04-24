//
//  AdvertisemImageNameModel.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class AdvertisemImageNameModel:NSObject {

   var advertisemImageNames:[String] = []
   
    class func defaultAdvertisemImageNameModel(jsonString:String) -> AdvertisemImageNameModel! {
        let adv =  AdvertisemImageNameModel()
        let json = MJson.json(jsonString)
        let jsonlist = json.array
        let count = jsonlist?.count
        for var i = 0 ; i<count ; i = i+1 {
          adv.advertisemImageNames.append(jsonlist![i].string!)
        }
        return adv
    }
}
