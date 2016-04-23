//
//  PersonalInfoCellAddress.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class PersonalInfoCellAddress: UITableViewCell {
    
    let labView = UILabel()
    
    func initView() {
        
        selectionStyle = .None
        
        labView.text = "收货地址管理"
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: autoSize(16, max: 18))
        addSubview(labView)
        
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        
        labView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(40)
            make.centerY.equalTo(self)
        }
        
        let rightIcon = UIImageView(image: UIImage(named: "icon_right")).addTo(self)
        rightIcon.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
        
        Line.defaultLine(20, right: 0, color: MColor.lineUserInfoColor).addTo(self)
    }

}
