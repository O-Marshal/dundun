//
//  BindingTableViewCell.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class BindingTableViewCell: BillTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func extensionSubViewLayout() {
        let superView = self.contentView
        titleLable?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(superView).offset(7)
            make.left.equalTo((billImageView?.snp_right)!).offset(10)
            make.width.equalTo(100)
            
        })
        detail?.snp_makeConstraints(closure: { (make) -> Void in
            make.bottom.equalTo(superView).offset(-7)
            make.left.equalTo((billImageView?.snp_right)!).offset(10)
            make.height.equalTo(timeLable!)
        })
        timeLable?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(superView)
            make.right.equalTo(superView).offset(-5)
        })
        
    }

    
}
