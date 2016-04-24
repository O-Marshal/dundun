//
//  MasageTableViewCell.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MasageTableViewCell: BillTableViewCell {
  
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleLable?.font = UIFont.systemFontOfSize(15)
        detail?.lineBreakMode = .ByWordWrapping
        detail?.numberOfLines = 0
        detail?.font = UIFont.systemFontOfSize(12)

        timeLable?.font = UIFont.systemFontOfSize(12)
    
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
            make.right.equalTo(superView).offset(-5)
            
        })

        timeLable?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(superView).offset(7)
            make.height.equalTo(12)
            make.right.equalTo(superView).offset(-5)
        
        })

    }
}
