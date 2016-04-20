//
//  LogoView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class LogoView: UILabel {
    
    class func defaultLogo() -> UILabel {
        let logo = LogoView()
        logo.text = "DUNDUN"
        logo.font = UIFont.boldSystemFontOfSize(50)
        logo.textColor = UIColor.whiteColor()
        return logo
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.centerX.equalTo(superview!)
        }
    }
    

}
