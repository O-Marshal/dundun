//
//  WalletMoneyView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/24.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletMoneyView: UIView {
    
    let moneyView = UILabel()
    
    func setData(number: String?) {
        moneyView.text = number
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.width.equalTo(superview!)
            make.height.equalTo(70)
        }
        
        let labView = UILabel()
        labView.text = "可用余额"
        labView.font = UIFont(name: "Oriya Sangam MN", size: 15)
        labView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
        }
        moneyView.text = "12312.12"
        moneyView.font = UIFont(name: "Heiti SC", size: 24)
        moneyView.textColor = MColor.infoErrorColor
        moneyView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(labView.snp_bottom)
            make.centerX.equalTo(self)
        }
        
        backgroundColor = UIColor.whiteColor()
    }

}
