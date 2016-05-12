//
//  NoneCollectionVIewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/5/3.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class NoneCollectionVIewCell: UICollectionViewCell {
    
    let imgVIew  = UIImageView(image: UIImage(named: "icon_nothing")?.image(UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6), backgroundColor: UIColor.clearColor()))
    let labView = UILabel()
    
    override func didMoveToSuperview() {
        labView.textColor = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 0.6)
        labView.font = UIFont(name: "Heiti SC", size: 18)
        backgroundColor = MColor.backgroundColor
        if superview == nil { return }
        
        imgVIew.addTo(self).snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.5)
            make.width.height.equalTo(50)
        }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(imgVIew.snp_bottom).offset(20)
            make.centerX.equalTo(self)
        }
    }
    
    func initView(info: String) {
        labView.text = info
    }
    
}
