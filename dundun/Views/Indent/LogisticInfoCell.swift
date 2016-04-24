//
//  LogisticInfoCell.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/11.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class LogisticInfoCell: UITableViewCell {
     override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let circle = CircleView()
        // 链式调用
        contentView.addSubview(circle.initGroup(themColor))
        circle.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(25)
            make.left.equalTo(contentView).offset(15)
            make.size.equalTo(CGSizeMake(8, 8))
        }
        // 创建时间
        let timeLabel = UILabel()
        timeLabel.text = "2016年3月5日 下午4:28"
        timeLabel.textColor = UIColor.grayColor()
        timeLabel.font = UIFont.boldSystemFontOfSize(14)
        contentView.addSubview(timeLabel)
        timeLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(circle.snp_top)
            make.left.equalTo(circle.snp_right).offset(5)
        }
        // 创建物流信息
        let infoLabel = UILabel()
        infoLabel.text = "您的包裹已出库"
        infoLabel.textColor = UIColor.grayColor()
        infoLabel.font = UIFont.boldSystemFontOfSize(14)
        contentView.addSubview(infoLabel)
        infoLabel.snp_makeConstraints { (make) in
            make.top.equalTo(circle.snp_bottom)
            make.left.equalTo(circle.snp_right).offset(5)
        }
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
