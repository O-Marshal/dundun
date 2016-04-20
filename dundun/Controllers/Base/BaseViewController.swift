//
//  BaseViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        
        initCommonNavBackItem()
        initView()
    }
    
    //MARK: - 初始化视图 -
    func initView() {
        
    }
    
    override func viewWillAppear(animated: Bool) {
        MobClick.beginLogPageView("\(classForCoder)")
    }
    override func viewWillDisappear(animated: Bool) {
        MobClick.endLogPageView("\(classForCoder)")
    }
    
}
