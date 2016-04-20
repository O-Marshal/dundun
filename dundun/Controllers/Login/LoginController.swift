//
//  LoginController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class LoginController {

    class func login(viewController:UIViewController){
        let controller = MNavigationController(rootViewController: LoginViewController())
        viewController.presentViewController(controller, animated: true, completion: nil)
    }
}
