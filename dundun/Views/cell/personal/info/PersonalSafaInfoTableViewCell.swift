//
//  PersonalSafaInfoTableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/5/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class PersonalSafaInfoTableViewCell: UITableViewCell {
    
    let imgView = UIImageView()
    let labView = UILabel()
    
    func initView(lab: String, img: String) {
        
        selectionStyle = .None
        
        labView.text = lab
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: 18)
        addSubview(labView)
        
        imgView.image = UIImage(named: img)
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 20
        addSubview(imgView)
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        
        imgView.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalTo(self)
            make.width.height.equalTo(40)
        }
        
        labView.snp_makeConstraints { (make) in
            make.left.equalTo(imgView.snp_right).offset(10)
            make.centerY.equalTo(self)
        }
        
        
        Line.defaultLine(20, right: 20, color: MColor.lineUserInfoColor).addTo(self)
    }
    
}
