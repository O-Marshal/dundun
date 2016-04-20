//
//  MButton.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MButton: UIButton {
    
    class func themButton(title: String, target: UIViewController, action: Selector) -> MButton {
        let btn = MButton()
        btn.setTitle(title, forState: .Normal)
        btn.backgroundColor = MColor.themeColor
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return btn
    }
    
    class func whiteButton(title: String, target: UIViewController, action: Selector) -> MButton {
        let btn = MButton()
        btn.setTitle(title, forState: .Normal)
        btn.backgroundColor = UIColor.whiteColor()
        btn.setTitleColor(MColor.themeColor, forState: .Normal)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return btn
    }

}
