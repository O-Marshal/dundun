//
//  PersonalInfoCellTextField.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class PersonalInfoCellHeader: UITableViewCell {
    
    let labView = UILabel()
    let imgView = UIImageView()
    
    func initView() {
        
        selectionStyle = .None
        
        labView.text = "头像"
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: autoSize(16, max: 18))
        addSubview(labView)
        
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 30
        addSubview(imgView)
    }
    
    func setData(img: UIImage?) {
        if img != nil {
            self.imgView.image = img ?? UIImage(named: "user_defaultIcon")
        }
    }
    func setImageString(img: String?) {
        if img != nil {
            imgView.kf_setImageWithURL(NSURL(string: img!)!, placeholderImage: UIImage(named: "user_defaultIcon"))
        } else {
            imgView.image = UIImage(named: "user_defaultIcon")
        }
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        
        labView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(40)
            make.centerY.equalTo(self)
        }
        imgView.snp_makeConstraints { (make) in
            make.left.equalTo(labView.snp_right).offset(50)
            make.centerY.equalTo(self)
            make.width.height.equalTo(60)
        }
        
        Line.defaultLine(20, right: 0, color: MColor.lineUserInfoColor).addTo(self)
    }
    

}
