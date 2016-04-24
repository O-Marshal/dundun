//
//  ReciveViewController.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class ReciveViewController: SellerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 因为是继承卖家发货界面的控制器,所以得先移除不要的控件
        for subView:UIView in view.subviews {
            if [2003,1003].contains(subView.tag){
                subView.removeFromSuperview()
            }
            
        }
        
        let colors = [blue, blue, blue, blue, themColor, themColor, themColor]
        self.createIndentFlow(view, colors: colors, tag: 104)
        
        let affimView = createAffimView(view, tag: 2004)
        // 确认收货btn
        let rightView = createRightView(affimView, rightTitle: "确认收货")
//        rightView.rx_controlEvent(.TouchUpInside).subscribeNext{
//            self.showViewController(RefundViewController(), sender: nil)
//            print("再点我就吃掉你")
//        }
        // 查看物流btn
        let leftBtn = creatLeftView(affimView, leftTitle: "查看物流", isCount: false, isBtn: true) as? UIButton
        leftBtn?.withAction(self, selector: #selector(ReciveViewController.shows))
    }
    func shows() {
        showViewController(LogisticInfoController(), sender: nil)
    }
    
}
