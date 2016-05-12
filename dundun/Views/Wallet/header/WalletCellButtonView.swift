//
//  WalletCellButtonView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletCellButtonView: UIView {
    
    let labView = UILabel()
    
    var delegate: MButtonEventIdentifyDelegate?
    
    override func didMoveToSuperview() {
        backgroundColor = UIColor.whiteColor()
        let tap = UITapGestureRecognizer(target: self, action: #selector(touchEvent))
        addGestureRecognizer(tap)
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.top.equalTo(570)
            make.height.equalTo(60)
            make.width.equalTo(superview!)
        }
        
        labView.text = "账户详情"
        labView.font = UIFont.systemFontOfSize(autoSize(14, max: 16))
        labView.textColor =  MColor.textHeaderColor
        labView.addTo(self).snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(20)
        }
        let rightIcon = UIImageView(image: UIImage(named: "icon_right")).addTo(self)
        rightIcon.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
    }
    
    func touchEvent() {
        delegate?.onTouchEvent("cell")
    }

}
