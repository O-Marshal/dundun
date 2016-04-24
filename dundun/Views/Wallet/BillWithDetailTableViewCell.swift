//
//  BillWithDetailTableViewCell.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class BillWithDetailTableViewCell: BillTableViewCell {

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
        moneyLable?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(superView).offset(7)
            make.right.equalTo(superView).offset(-5)
        })
        timeLable?.snp_makeConstraints(closure: { (make) -> Void in
            make.bottom.equalTo(superView).offset(-7)
            make.top.equalTo((moneyLable?.snp_bottom)!).offset(5)
            make.right.equalTo(superView).offset(-5)
            make.height.equalTo(moneyLable!)
        })
    }

}
