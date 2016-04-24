//
//  MoneyView.swift
//  mySwift
//
//  Created by 王 on 16/4/10.
//  Copyright © 2016年 王允顶. All rights reserved.
//

import UIKit

class MoneyView: UIView {
    
    var _money : Money?
    var totalStr : UILabel?
    var totalInt : UILabel?
    var returnStr : UILabel?
    var returnInt : UILabel?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
//        money = Money()
//        money?.totalStr = "资产总额"
//        money?.totalInt = "2800.01"
//        money?.totalStr = "返现总额"
//        money?.totalInt = "200.20"
        
        self.setLabel()
        
        let decollate = UIView()
        self.addSubview(decollate)
        decollate.backgroundColor = groundColour
        decollate.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(10)
            make.bottom.equalTo(self).offset(-10)
            make.width.equalTo(1)
            make.center.equalTo(self.center)
        }
        
        
    }
    
    func money(money : Money)
    {
        _money = money
        
        totalStr?.text = money.totalStr
        totalInt?.text = money.totalInt
        
        returnStr?.text = money.returnStr
        returnInt?.text = money.returnInt
    }
    
    func setLabel()
    {
        totalStr = UILabel()
        self.addSubview(totalStr!)
        totalStr?.textAlignment = NSTextAlignment.Center
        totalStr?.snp_makeConstraints(closure: { (make) -> Void in
            
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(40)
            make.width.equalTo(100)
            make.height.equalTo(30)
        })
        totalInt = UILabel()
        self.addSubview(totalInt!)
        totalInt?.textAlignment = NSTextAlignment.Center
        
        totalInt?.snp_makeConstraints(closure: { (make) -> Void in
            
            make.bottom.equalTo(self).offset(-10)
            make.left.equalTo(self).offset(40)
            make.width.equalTo(100)
            make.height.equalTo(30)
        })
        
        
        returnStr = UILabel()
        self.addSubview(returnStr!)
        returnStr?.textAlignment = NSTextAlignment.Center
        
        returnStr?.snp_makeConstraints(closure: { (make) -> Void in
            
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-40)
            make.width.equalTo(100)
            make.height.equalTo(30)
        })
        returnInt = UILabel()
        self.addSubview(returnInt!)
        returnInt?.textAlignment = NSTextAlignment.Center
        
        returnInt?.snp_makeConstraints(closure: { (make) -> Void in
            
            make.bottom.equalTo(self).offset(-10)
            make.right.equalTo(self).offset(-40)
            make.width.equalTo(100)
            make.height.equalTo(30)
        })
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
