//
//  BillTableViewCell.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/12.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class BillTableViewCell: UITableViewCell {

    var billImageView:UIImageView?
    var titleLable:UILabel?
    var moneyLable:UILabel?
    var timeLable:UILabel?
    var detail:UILabel?
    let line = UIView()
    let lineColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1.0)
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        billImageView = UIImageView()
        self.contentView.addSubview(billImageView!)
        titleLable = UILabel()
        titleLable?.textAlignment = NSTextAlignment.Left
        self.contentView.addSubview(titleLable!)
        moneyLable = UILabel()
        moneyLable?.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(moneyLable!)
        timeLable = UILabel()
        timeLable?.textAlignment = NSTextAlignment.Right
        self.contentView.addSubview(timeLable!)
        detail = UILabel()
        self.contentView.addSubview(detail!)
        line.backgroundColor = lineColor
        self.contentView.addSubview(line)
        
        //字体
        titleLable?.font = UIFont.systemFontOfSize(15)
        detail?.lineBreakMode = .ByWordWrapping
        detail?.numberOfLines = 0
        detail?.font = UIFont.systemFontOfSize(12)
        detail?.textColor = UIColor.grayColor()
        timeLable?.font = UIFont.systemFontOfSize(12)
        timeLable?.textColor = UIColor.grayColor()
        moneyLable?.font = UIFont.systemFontOfSize(12)
        moneyLable?.textColor = UIColor.blueColor()
        layoutViews()
        extensionSubViewLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews(){
       let superView = self.contentView
        
        billImageView?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.left.equalTo(superView).offset(15)
            make.bottom.equalTo(superView).offset(-15)
            make.width.equalTo(40)
        })
        
        line.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(superView).offset(10)
            make.right.equalTo(superView).offset(-5)
            make.bottom.equalTo(superView)
            make.height.equalTo(2)
        })
    }
    
    func extensionSubViewLayout(){
        let superView = self.contentView
        titleLable?.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(superView)
            make.left.equalTo((billImageView?.snp_right)!).offset(10)
            make.width.equalTo(100)
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
