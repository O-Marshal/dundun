//
//  Alamofire_ExtensionViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/19.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Alamofire

extension UIViewController {
    
    func get(url: String) {
        async_queue(url) {
            Alamofire.request(.GET, url).responseData { (response) in
                if let data = response.data {
                    
                } else {
                    Notify.show(Murmur: "网络连接失败", theme: NotiTheme.Warring)
                }
            }
        }
    }
    
    func post(url: String, params: [String: String]) {
        Alamofire.request(.POST, url, parameters: params).responseData(completionHandler: { (response) in
            if let data = response.data {
                
            }
        })
    }

}
