//
//  AppDelegate.swift
//  dundun
//
//  Created by 刘荣 on 16/4/6.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        sleep(1)
        MobClick.startWithAppkey(UMKey, reportPolicy: BATCH, channelId: "")
        UMSocialData.setAppKey(UMKey)
        UMSocialWechatHandler.setWXAppId(WXKey, appSecret: WXSecrect, url: UMShareUrl)
        UMSocialQQHandler.setQQWithAppId(QQID, appKey: QQKey, url: UMShareUrl)
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey(WBKey, secret: WBSecrect, redirectURL: "http://dundun.mog.name/weibo")
        AMapSearchServices.sharedServices().apiKey = "2de9c4dedb34631586c1b20bd516984e"
        
        // 融云
        RCIM.sharedRCIM().initWithAppKey("x4vkb1qpvdfyk")
        
        window = MWindow.defaultWindow
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        let result = UMSocialSnsService.handleOpenURL(url)
        return result
    }
}

