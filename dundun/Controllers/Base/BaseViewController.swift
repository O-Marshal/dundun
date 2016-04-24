//
//  BaseViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

enum AlamofireResultType {
    case OK
    case Api
    case Net
}
typealias AlamofireResultError = (type: AlamofireResultType, info: String)

/**
 *  网络请求协议
 */
protocol UIViewControllerWithNetWorking {
    
    var netDelegate: UIViewControllerWithNetWorking? { get }
    
    func netSuccess(result: String, identifier: String?)
    
    func netError(errorType: AlamofireResultType, errorInfo: String, identifier: String?)
    
    func netErrorAuth()
}

class BaseViewController: UIViewController, UIViewControllerWithNetWorking {
    
    var netDelegate: UIViewControllerWithNetWorking?
    
    override func viewDidLoad() {
        
        netDelegate = self
        view.backgroundColor = MColor.backgroundColor
        
        initCommonNavBackItem()
        initView()
        initEvent()
    }
    
    //MARK: - 初始化视图 -
    func initView() {
        
    }
    
    func initEvent() {
        
    }
    
    func loginSuccess() {
        print("登录成功")
    }
    
    /**
     请求成功
     */
    func netSuccess(result: String, identifier: String?) {
        print("identifier:\(identifier)\nresult:\(result)")
    }
    
    /**
     请求错误
     */
    func netError(errorType: AlamofireResultType, errorInfo: String, identifier: String?) {
        print("identifier:\(identifier)\nerrorInfo:\(errorInfo)")
        Notify.show(Whisper: errorInfo, theme: NotiTheme.Warring, viewController: self)
    }
    
    /**
     用户需要登录
     */
    func netErrorAuth() {
        Notify.show(Murmur: "用户校验失败，需要登录", theme: NotiTheme.Warring)
//        LoginController.login(self)
        print("用户授权失败，需要重新登录")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        MobClick.beginLogPageView("\(classForCoder)")
    }
    override func viewWillDisappear(animated: Bool) {
        MobClick.endLogPageView("\(classForCoder)")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        dismissKeyBoard(view)
    }
    /** 影藏键盘 */
    internal func dismissKeyBoard(mView: UIView){
        if mView.isKindOfClass(UITextField) || mView.isKindOfClass(UITextView) {
            (mView as! UITextField).resignFirstResponder()
        }
        if mView.subviews.count == 0 { return }
        for subview in mView.subviews{
            dismissKeyBoard(subview)
        }
    }
}
