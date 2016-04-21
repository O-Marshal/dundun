//
//  ExtensionUIviewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

extension UIViewController {
    func dismissEvent() {
        //  如果当前控制器是window的根视图控制器，则不执行任何操作
        if UIApplication.sharedApplication().keyWindow?.rootViewController == (self == navigationController ? navigationController : self) {
            return
        }
        if navigationController == nil { // 当前控制器没有导航控制器，则执行Dismiss方法
            dismissViewControllerAnimated(true, completion: nil)
        } else if self == navigationController?.childViewControllers.first {//  如果当前控制器是导视图的根视图，且不是UIWindow的根视图，就Dismiss掉当前导航控制器
            navigationController?.dismissViewControllerAnimated(true, completion: nil)
        } else {//  否则返回到上一个导航控制器
            navigationController?.popViewControllerAnimated(true)
        }
    }
}

extension UIViewController {
    /**
     重写NavgationBar返回按钮样式
     */
    func initCommonNavBackItem(image: String = "nav_back") {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: image), style: .Plain, target: self, action: #selector(dismissEvent))
    }
    
    func changeScrollView() {
        let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        scrollView.addSubview(view)
        scrollView.contentSize = CGSize(width: 0, height: 700)
        scrollView.backgroundColor = MColor.themeColor
        view = scrollView
    }
}

//  事件相关
extension UIViewController {
    
    func addsubView(targetView: UIView) {
        view.addSubview(targetView)
    }
    
}
