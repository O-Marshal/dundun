//
//  PersonalIndexTableViewCellHeader.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit

class PersonalIndexTableViewCellHeader: UITableViewCell {
    
    let imgView = UIImageView()
    let labView = UILabel()
    
    func initView() {
        
        selectionStyle = .None
        
        imgView.image = UIImage(named: "icon_imageLoading")
        labView.text = "撒打算阿萨德"
        labView.font = UIFont.systemFontOfSize(autoSize(14, max: 16))
        labView.textColor =  MColor.textHeaderColor
        addSubview(imgView)
        addSubview(labView)
        
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 30
        
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
