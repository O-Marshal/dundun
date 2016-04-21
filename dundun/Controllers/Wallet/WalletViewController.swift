//
//  WalletViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Alamofire

class WalletViewController: BaseViewController {
    
    override func viewDidLoad() {
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50 ))
        addsubView(btn)
        
        btn.backgroundColor = UIColor.redColor()
        
        btn.addTarget(self, action: #selector(load), forControlEvents: .TouchUpInside)
        
    }
    
    func load() {
        print(LoginController.userInfo())
    }

}
