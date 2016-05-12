//
//  MDefaultTableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MDefaultTableViewCell: UITableViewCell {
    
    let labView = UILabel()
    
    let numView = UILabel()
    
    var isNext = false
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(20)
        }
        numView.addTo(self).snp_makeConstraints { (make) in
            make.left.equalTo(labView.snp_right).offset(20)
            make.centerY.equalTo(self)
        }
        if isNext {
            let rightIcon = UIImageView(image: UIImage(named: "icon_right")).addTo(self)
            rightIcon.snp_makeConstraints { (make) in
                make.right.equalTo(self).offset(-20)
                make.centerY.equalTo(self)
            }
        }
    }
    
    func setLab(lab: String) {
        labView.text = lab
    }
    
    func setData(num: String) {
        numView.text = num
    }
    
    func setNext() {
        isNext = true
    }
    
    private func initView() {
        selectionStyle = .None
        backgroundColor = UIColor.whiteColor()
        
        labView.font = UIFont(name: "Heiti SC", size: 16)
        numView.font = UIFont.systemFontOfSize(18)
        
        labView.textColor = MColor.textHeaderColor
        numView.textColor = MColor.infoErrorColor
        
    }
}
