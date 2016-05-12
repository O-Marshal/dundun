//
//  WalletCardInfoTableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/5/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletCardInfoTableViewCell: UITableViewCell {
    
    let labView = UILabel()
    let infoView = UILabel()
    
    var isLast = false
    
    func initView(lab: String, info: String) {
        
        selectionStyle = .None
        labView.text = lab
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: autoSize(16, max: 18))
        labView.textAlignment = .Right
        
        infoView.text = info
        infoView.textColor = MColor.textPlacholderColor
        infoView.font = UIFont(name: "Heiti SC", size: 16)
    }
    
    func setInfoColor(infoColor: UIColor) {
        infoView.textColor = infoColor
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        
        labView.addTo(self).snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.width.equalTo(80)
            make.centerY.equalTo(self)
        }
        
        infoView.addTo(self).snp_makeConstraints { (make) in
            make.left.equalTo(labView.snp_right).offset(20)
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
        
        if !isLast {
            Line.defaultLine(10, right: 0, color: MColor.lineUserInfoColor).addTo(self)
        }
    }
}