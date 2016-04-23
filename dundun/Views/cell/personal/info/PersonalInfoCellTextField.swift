//
//  PersonalInfoCellHeader.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class PersonalInfoCellTextField: UITableViewCell {
    
    let labView = UILabel()
    let textField = UITextField()
    
    func initView() {
        
        selectionStyle = .None
        
        labView.text = "昵称"
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: autoSize(16, max: 18))
        addSubview(labView)
        
        textField.attributedPlaceholder = NSAttributedString(string: "请输入你的昵称", attributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: autoSize(16, max: 18))!, NSForegroundColorAttributeName: MColor.textPlacholderColor])
        addSubview(textField)
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        
        labView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(40)
            make.centerY.equalTo(self)
        }
        textField.snp_makeConstraints { (make) in
            make.left.equalTo(labView.snp_right).offset(50)
            make.centerY.equalTo(self)
        }
        
        Line.defaultLine(20, right: 0, color: MColor.lineUserInfoColor).addTo(self)
    }

}
