//
//  TestViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/19.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    override func viewDidLoad() {
        let qr = QRCodeWrapView()
        qr.frame = view.frame
        view = qr
        view.backgroundColor = UIColor.whiteColor()
    }

}
