//
//  LoginController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class LoginController {

    class func login(viewController:BaseViewController){
        let loginViewController = LoginViewController()
        loginViewController.delegate = viewController
        let controller = MNavigationController(rootViewController: loginViewController)
        viewController.presentViewController(controller, animated: true, completion: nil)
    }
    
    class func userSave(userId: Int, token: String) {
        let user = NSUserDefaults.standardUserDefaults()
        user.setInteger(userId, forKey: "userId")
        user.setValue(token, forKeyPath: "userToken")
        user.synchronize()
    }
    
    /**
     获取用户信息
     
     - returns: 返回用户信息：字典
     */
    class func userInfo() -> [String: AnyObject] {
        let user = NSUserDefaults.standardUserDefaults()
        let userID = user.integerForKey("userId") ?? 0
        let userToken: String = user.stringForKey("userToken") ?? ""
        return ["userID": userID, "userToken": userToken]
    }
    
}
