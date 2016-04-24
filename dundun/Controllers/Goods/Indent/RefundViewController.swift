//
//  RefundViewController.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/11.
//  Copyright © 2016年 Microali. All rights reserved.
//

// 退款界面
import UIKit

class RefundViewController: SellerViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let affimView = createAffimView(view, tag: 2005)
        affimView.backgroundColor = red
        let label = UILabel()
        label.text = "申请退款中"
        affimView.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.centerX.equalTo(affimView)
            make.top.equalTo(affimView).offset(15)
        }
    }
}
