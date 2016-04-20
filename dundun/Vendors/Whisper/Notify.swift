//
//  Noti.swift
//  dundun
//
//  Created by 刘荣 on 16/4/19.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Whisper


enum NotiTheme {
    case Success
    case Info
    case Warring
    case Error
}

class Notify {
    
    /**
     Whisper - 导航栏底部通知
     
     - parameter title:          标题
     - parameter theme:          主题： 成功，提醒， 警告， 错误
     - parameter viewController: 视图控制器
     */
    class func show(Whisper title: String, theme: NotiTheme, viewController: UIViewController) {
        if let nav = viewController.navigationController {
            let message = Message(title: title, textColor: getTextColor(theme), backgroundColor: getBackgroundColor(theme), images: nil)
            Whisper(message, to: nav)
        }
    }
    
    /**
     Murmur - 状态栏 全局通知
     
     - parameter title:          标题
     - parameter theme:          主题：成功，提醒， 警告， 错误
     */
    class func show(Murmur title: String, theme: NotiTheme) {
        let murmur = Murmur(title: title, duration: 2, backgroundColor: getBackgroundColor(theme), titleColor: getTextColor(theme), font: UIFont(name: "Oriya Sangam MN", size: 10)!)
        Whistle(murmur)
    }
    
    
    class func getTextColor(theme: NotiTheme) -> UIColor {

        return UIColor.whiteColor()
    }
    class func getBackgroundColor(theme: NotiTheme) -> UIColor {
        switch theme {
        case .Success:
            return UIColor(red: 31/255, green: 185/255, blue: 34/255, alpha: 1)
        case .Info:
            return UIColor(red: 36/255, green: 176/255, blue: 252/255, alpha: 1)
        case .Warring:
            return UIColor(red: 253/255, green: 189/255, blue: 44/255, alpha: 1)
        case .Error:
            return UIColor(red: 245/255, green: 99/255, blue: 100/255, alpha: 1)
        }
    }
}
