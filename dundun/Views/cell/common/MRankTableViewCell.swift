//
//  MRankTableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MRankTableViewCell: UITableViewCell {
    
    let labView = UILabel()
    let numView = UILabel()
    let imgView = UIImageView()
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        imgView.addTo(self).snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).offset(-15)
            make.height.equalTo(120)
            make.width.equalTo(120 * 1.5)
        }
        numView.addTo(self).snp_makeConstraints { (make) in
            make.center.equalTo(imgView)
        }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(self).offset(-10)
        }
    }
    
    func setData(num: String) {
        numView.text = num
    }
    
    private func initView() {
        selectionStyle = .None
        backgroundColor = UIColor.whiteColor()
        
        labView.text = "当前排名"
        
        labView.font = UIFont(name: "Heiti SC", size: 18)
        numView.font = UIFont.systemFontOfSize(25)
        
        labView.textColor = MColor.textHeaderColor
        numView.textColor = UIColor.whiteColor()
        
        imgView.image = UIImage(named: "icon_rank")
        
    }
    
}
