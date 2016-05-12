//
//  MWindow.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MWindow: UIWindow {
    
    static let defaultWindow = MWindow()
    
    private init() {
        super.init(frame: MSize.defaultSize.frame)
        rootViewController = MNavigationController(rootViewController: MTabBarController.defaultTabBar)
        let dundun = NSUserDefaults.standardUserDefaults()
        let theFirst = dundun.boolForKey("app_first")
        if !theFirst {
            rootViewController = TheFirstViewController()
        } else {
            rootViewController = MNavigationController(rootViewController: MTabBarController.defaultTabBar)
        }
        makeKeyAndVisible()
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
