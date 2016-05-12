//
//  ActivetableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/25.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class ActivetableViewCell: UITableViewCell {
    
    let imgView = UIImageView()
    let titleView = UILabel()
    let labView = UILabel()
    
    func initView(model: ActiveModel) {
        selectionStyle = .None
        
        titleView.text = model.title
        imgView.kf_setImageWithURL(NSURL(string: model.img!)!, placeholderImage: UIImage(named: "icon_imageLoading"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        
        imgView.contentMode = .ScaleAspectFill
        
//        titleView.font = UIFont(name: "Heiti SC", size: 18)
        titleView.font = UIFont.boldSystemFontOfSize(20)
        titleView.backgroundColor = UIColor.clearColor()
        titleView.textColor = UIColor.whiteColor()
        titleView.clipsToBounds = true
        titleView.layer.borderColor = UIColor.whiteColor().CGColor
        titleView.layer.borderWidth = 2
        titleView.layer.cornerRadius = 20
        titleView.textAlignment = .Center
        
        labView.text = model.label
        labView.textColor = UIColor.whiteColor()
        labView.font = UIFont.boldSystemFontOfSize(16)
        
        clipsToBounds = true
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        
        imgView.addTo(self).snp_makeConstraints { (make) in
            make.size.equalTo(self)
        }
        
        titleView.addTo(self).snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-15)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        labView.addTo(self).snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(titleView.snp_bottom).offset(10)
        }
    }

}
