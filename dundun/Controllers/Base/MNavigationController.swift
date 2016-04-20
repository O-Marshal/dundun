//
//  MNavigationController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        let navbar = navigationBar
        navbar.barTintColor = MColor.themeColor
        navbar.translucent = false
        //  渲染颜色
        navbar.tintColor = UIColor.whiteColor()
        navbar.barStyle = UIBarStyle.BlackTranslucent
        //  除去底部阴影细线
        navbar.shadowImage = UIImage()
        navbar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        view.backgroundColor = UIColor.whiteColor()
    }
    

}
