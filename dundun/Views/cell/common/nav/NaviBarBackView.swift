//
//  NaviBarBackView.swift
//  dundun
//
//  Created by 刘荣 on 16/5/5.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class NaviBarBackView: UIButton {
    
    class func defaultButton() -> NaviBarBackView {
        return NaviBarBackView()
    }
    
    override func didMoveToSuperview() {
        if superview == nil {return }
        snp_makeConstraints { (make) in
            make.top.equalTo(30)
            make.left.equalTo(20)
            make.width.height.equalTo(30)
        }
        setImage(UIImage(named: "nav_back_c"), forState: .Normal)
    }

}
