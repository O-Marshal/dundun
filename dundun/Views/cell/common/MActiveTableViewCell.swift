//
//  MActiveTableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MActiveTableViewCell: UITableViewCell {
    
    let labView = UILabel()
    
    let imgView = UIImageView()
    let starView = UIImageView()
    let starWrapView = UIView()
    
    var persent: CGFloat = 0
    
    let scale = 65 / 12
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-20)
        }
        imgView.addTo(self).snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.height.equalTo(30)
            make.width.equalTo(30 * scale)
            make.bottom.equalTo(self).offset(-30)
        }
        starWrapView.addTo(self).snp_makeConstraints { (make) in
            make.left.height.bottom.equalTo(imgView)
            make.width.equalTo(imgView).multipliedBy(persent)
        }
        starView.addTo(starWrapView).snp_makeConstraints { (make) in
            make.left.width.height.bottom.equalTo(imgView)
        }
    }
    
    func setData(num: CGFloat) {
        persent = num
    }
    
    private func initView() {
        selectionStyle = .None
        backgroundColor = UIColor.whiteColor()
        
        labView.text = "当前排名"
        
        labView.font = UIFont(name: "Heiti SC", size: 18)
        
        labView.textColor = MColor.textHeaderColor
        
        imgView.image = UIImage(named: "icon_star_gray")
        starView.image = UIImage(named: "icon_star_highlight")
        
        starWrapView.clipsToBounds = true
        
    }
}
