//
//  ViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/6.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        view.addSubview(btn)
        btn.backgroundColor = UIColor.blueColor()
        btn.rx_controlEvent(.TouchUpInside).subscribeNext {
            self.showViewController(RegistViewController(), sender: nil)
        }
    }


}

