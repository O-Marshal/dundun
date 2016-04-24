//
//  PersonalIndexTableViewCellHeader.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class PersonalIndexTableViewCellHeader: UITableViewCell {
    
    let imgView = UIImageView()
    let labView = UILabel()
    
    func initView() {
        
        selectionStyle = .None
        
        imgView.image = UIImage(named: "user_defaultIcon")
        labView.text = "昵称"
        labView.font = UIFont.systemFontOfSize(autoSize(14, max: 16))
        labView.textColor =  MColor.textHeaderColor
        addSubview(imgView)
        addSubview(labView)
        
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 30
    }
    
    func setData(img: String?,nick: String?) {
        if img != nil {
            imgView.kf_setImageWithURL(NSURL(string: img!)!, placeholderImage: UIImage(named: "user_defaultIcon"))
        }
        if nick != nil {
            labView.text = nick
        }
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        imgView.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(10)
            make.width.height.equalTo(60)
        }
        labView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.left.equalTo(imgView.snp_right).offset(20)
        }
        let rightIcon = UIImageView(image: UIImage(named: "icon_right")).addTo(self)
        rightIcon.snp_makeConstraints { (make) in
            make.right.equalTo(self).offset(-20)
            make.centerY.equalTo(self)
        }
    }
    
    

}
