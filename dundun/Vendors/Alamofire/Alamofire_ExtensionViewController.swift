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
    
    func get(url: String, identifier: String? = nil) {
        Alamofire.request(.GET, url).responseData { (response) in
            self.result(response, identifier: identifier)
        }
    }
    
    func post(url: String, params: [String: AnyObject], identifier: String? = nil) {
        Alamofire.request(.POST, url, parameters: params).responseData(completionHandler: { (response) in
            self.result(response, identifier: identifier)
        })
    }
    
    /**
     postWithLogin - 带用户登录的网络请求
     */
    func postWithLogin(url: String, params: [String: AnyObject], identifier: String? = nil) {
        var newParams = params
        newParams["userID"] = LoginController.userInfo()["userID"]
        newParams["userToken"] = LoginController.userInfo()["userToken"]
        Alamofire.request(.POST, url, parameters: newParams).responseData(completionHandler: { (response) in
            self.result(response, identifier: identifier)
        })
    }
    
    func postImageWithLogin(url: String, params: [String: AnyObject], identifier: String? = nil) {
        Alamofire.upload(.POST, url, multipartFormData: { (datas) in
            for param in params {
                if param.1 is NSData {
                    datas.appendBodyPart(data: param.1 as! NSData, name: param.0, fileName: param.0, mimeType: "image/*")
                } else {
                    datas.appendBodyPart(data: "\(param.1)".dataUsingEncoding(NSUTF8StringEncoding)!, name: param.0)
                }
            }
            let userID: NSData = "\(LoginController.userInfo()["userID"]!)".dataUsingEncoding(NSUTF8StringEncoding)!
            let userToken: NSData = "\(LoginController.userInfo()["userToken"]!)".dataUsingEncoding(NSUTF8StringEncoding)!
            datas.appendBodyPart(data: userID, name: "userID")
            datas.appendBodyPart(data: userToken, name: "userToken")
            print(datas.boundary)
            }) { (result) in
                switch result {
                case .Success(let upload, _, _):
                    upload.responseData(completionHandler: { (response) in
                        self.result(response, identifier: identifier)
                    })
                case .Failure( _):
                    self.netDelegate?.netError(AlamofireResultType.Api, errorInfo: "网络连接失败", identifier: identifier)
                }
        }
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
                self.netDelegate?.netError(AlamofireResultType.Api, errorInfo: json["errMsg"].description, identifier: identifier)
            }
        } else {
            self.netDelegate?.netError(AlamofireResultType.Net, errorInfo: "网络连接失败", identifier: identifier)
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
