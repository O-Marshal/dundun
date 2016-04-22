//
//  Alamofire_ExtensionViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/19.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

extension BaseViewController {
    
    /**
     get - 网络请求 ： 网络请求都是异步线程， 如果需要在主线程执行回调，请使用async_main方法
     */
    func get(url: String, identifier: String? = nil) {
        Alamofire.request(.GET, url).responseData { (response) in
            self.result(response, identifier: identifier)
        }
    }
    
    /**
     post - 网络请求 ： 网络请求都是异步线程， 如果需要在主线程执行回调，请使用async_main方法
     */
    func post(url: String, params: [String: AnyObject], identifier: String? = nil) {
        Alamofire.request(.POST, url, parameters: params).responseData(completionHandler: { (response) in
            self.result(response, identifier: identifier)
        })
    }
    
    private func result(response: Response<NSData, NSError>, identifier: String?) {
        if let data = response.data {
            let json = JSON(data: data)
            switch json["errCode"].intValue {
            case 1:
                self.netDelegate?.netSuccess(json["data"].description, identifier: identifier)
            case -2: // 需要登录
                self.netDelegate?.netErrorAuth()
            default :
                self.netDelegate?.netError(AlamofireResultType.Api, errorInfo: json["errMsg"].stringValue, identifier: identifier)
            }
        } else {
            self.netDelegate?.netError(AlamofireResultType.Api, errorInfo: "网络连接失败", identifier: identifier)
        }
    }
    
    private func replaceString(str: String) -> String {
        var newStr = str.stringByReplacingOccurrencesOfString("\n", withString: "")
//        newStr.substringTo(newStr.rangeOfString(",").location)
        newStr = newStr.stringByReplacingOccurrencesOfString(":", withString: "")
        newStr = newStr.stringByReplacingOccurrencesOfString(" ", withString: "")
        newStr = newStr.stringByReplacingOccurrencesOfString("{", withString: "")
        newStr = newStr.stringByReplacingOccurrencesOfString("}", withString: "")
        newStr = newStr.stringByReplacingOccurrencesOfString("[", withString: "")
        newStr = newStr.stringByReplacingOccurrencesOfString("]", withString: "")
        newStr = newStr.stringByReplacingOccurrencesOfString("\"", withString: "")
        for i in 0...9 {
            newStr = newStr.stringByReplacingOccurrencesOfString("\(i)", withString: "")
        }
        return newStr
    }
}
