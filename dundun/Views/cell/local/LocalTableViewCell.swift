//
//  LocalTableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/25.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class LocalTableViewCell: UITableViewCell {
    
    let labView = UILabel()
    let dscView = UILabel()
    let imgView = UIImageView()
    let destView = UILabel()
    
    func setData(name: String,logo: String, desc: String, dest: Float) {
        labView.text = name
        dscView.text = desc
        destView.text = "\(dest) m"
        imgView.m_setImage(logo)
    }
    
    private func initView() {
        
        selectionStyle = .None
        
        labView.textColor = MColor.textLabelColor
        dscView.textColor = MColor.textPlacholderColor
        destView.textColor = MColor.textHeaderColor
        
        labView.font = UIFont.boldSystemFontOfSize(18)
        dscView.font = UIFont.systemFontOfSize(15)
        destView.font = UIFont.systemFontOfSize(12)
        
        dscView.numberOfLines = 2
        
        imgView.image = UIImage(named: "icon_imageLoading")
    }
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        imgView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(20)
            make.width.height.equalTo(80)
        }
        
        labView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(imgView)
            make.left.equalTo(imgView.snp_right).offset(20)
            make.right.equalTo(-20)
        }
        dscView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(labView.snp_bottom).offset(5)
            make.left.equalTo(labView)
            make.right.equalTo(-20)
        }
        destView.addTo(self).snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.left.equalTo(labView)
        }
        Line.defaultLine(0, color: MColor.lineDefaultColor).addTo(self)
    }

}
