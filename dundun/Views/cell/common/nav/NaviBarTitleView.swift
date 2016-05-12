//
//  NaviBarTitleView.swift
//  dundun
//
//  Created by 刘荣 on 16/5/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class NaviBarTitleView: UILabel {
    
    class func defaultView(title: String) -> NaviBarTitleView {
        let lab = NaviBarTitleView()
        lab.text = title
        lab.textColor = UIColor.whiteColor()
        if #available(iOS 8.2, *) {
            lab.font = UIFont.systemFontOfSize(18, weight: 900)
        } else {
            lab.font = UIFont.systemFontOfSize(18)
        }
        return lab
    }
    
    override func didMoveToSuperview() {
        if superview == nil {return }
        snp_makeConstraints { (make) in
            make.top.equalTo(30)
            make.centerX.equalTo(superview!)
        }
    }
    
}