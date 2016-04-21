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
    
    func netError(errorType: AlamofireResultType, errorInfo: String, errorData: String?, identifier: String?)
    
    func netErrorAuth()
    func netErrorCheck( errorData: String, identifier: String?)
}

class BaseViewController: UIViewController, UIViewControllerWithNetWorking {
    
    var netDelegate: UIViewControllerWithNetWorking?
    
    override func viewDidLoad() {
        
        netDelegate = self
        
        initCommonNavBackItem()
        initView()
        initEvent()
    }
    
    //MARK: - 初始化视图 -
    func initView() {
        
    }
    
    func initEvent() {
        
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
    func netError(errorType: AlamofireResultType, errorInfo: String, errorData: String?, identifier: String?) {
        print("identifier:\(identifier)\nerrorType:\(errorType)\nerrorInfo:\(errorInfo)\nerrorData:\(errorData)")
    }
    
    /**
     用户需要登录
     */
    func netErrorAuth() {
        print("用户授权失败，需要重新登录")
    }
    /**
     数据校验失败
     */
    func netErrorCheck(errorData: String, identifier: String?) {
        print("identifier:\(identifier)\nerrorData:\(errorData)")
    }
    
    
    override func viewWillAppear(animated: Bool) {
        MobClick.beginLogPageView("\(classForCoder)")
    }
    override func viewWillDisappear(animated: Bool) {
        MobClick.endLogPageView("\(classForCoder)")
    }
}
