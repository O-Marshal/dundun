//
//  PersonalIndexTableViewSgin.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class PersonalIndexTableViewCellSgin: UITableViewCell {
    
    private let box1 = PersonalIndexTableViewCellSginBoxView()
    private let box2 = PersonalIndexTableViewCellSginBoxView()
    
    func initView() {
        
        box1.boxView("user_invite", title: "邀请").addTo(self)
        box2.boxView("user_sign", title: "签到").addTo(self)
        
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        
        box1.snp_makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.5)
            make.centerY.equalTo(self)
            make.height.equalTo(40)
        }
        let line = UIView().withBack(MColor.lineUserInfoColor).addTo(box1)
        line.snp_makeConstraints { (make) in
            make.right.equalTo(box1)
            make.centerY.equalTo(box1)
            make.height.equalTo(box1).multipliedBy(0.9)
            make.width.equalTo(MSize.defaultSize.px(1))
        }
        
        box2.snp_makeConstraints { (make) in
            make.right.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.5)
            make.centerY.equalTo(self)
        }
        
    }
    
    
    
    

}

class PersonalIndexTableViewCellSginBoxView: UIButton {
    
    let imgView = UIImageView()
    let labView = UILabel()
    
    
    func boxView(img: String, title: String) -> PersonalIndexTableViewCellSginBoxView {
        imgView.addTo(self)
        labView.addTo(self)
        imgView.image = UIImage(named: img)
        labView.text = title
        labView.textColor = MColor.textLabelColor
        
        return self
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        imgView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self).offset(-30)
            make.width.height.equalTo(50)
        }
        
        labView.snp_makeConstraints { (make) in
            make.left.equalTo(imgView.snp_right).offset(10)
            make.centerY.equalTo(self)
        }

    }
    
}