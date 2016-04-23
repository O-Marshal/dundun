//
//  PersonalIndexTableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

// 默认列表
class PersonalIndexTableViewCell: UITableViewCell {
    
    let imgView = UIImageView()
    let labView = UILabel()
    
    var needLine = false
    
    func initView(img:String, title:String, line: Bool = false) {
        needLine = line
        
        selectionStyle = .None
        
        imgView.image = UIImage(named: img)
        labView.text = title
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: autoSize(15, max: 17))
        addSubview(imgView)
        addSubview(labView)
        
        imgView.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        imgView.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.centerY.equalTo(self)
            make.width.height.equalTo(25)
        }
        labView.snp_makeConstraints { (make) in
            make.left.equalTo(imgView.snp_right).offset(20)
            make.centerY.equalTo(self)
        }
        if needLine {
            Line.defaultLine(70, right: 0, color: MColor.lineDefaultColor).addTo(self)
        }
    }
    
}
