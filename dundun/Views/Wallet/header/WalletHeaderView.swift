//
//  WalletHeaderView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/24.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletHeaderView: UIView {
    
    var imgView = UIImageView()
    var labView = UILabel()
    
    var index = 0
    
    var delegate: MButtonEventIdentifyDelegate?
    
    func setDelegate(delegate: MButtonEventIdentifyDelegate) -> WalletHeaderView {
        self.delegate = delegate
        imgView.userInteractionEnabled = true
        let touch = UITapGestureRecognizer(target: self, action: #selector(touchEvent))
        imgView.addGestureRecognizer(touch)
        return self
    }
    
    class func headerView(index: Int) -> WalletHeaderView {
        let wallet = WalletHeaderView()
        wallet.index = index
        if index == 1 {
            wallet.imgView.image = UIImage(named: "wallet_cash")
            wallet.labView.text = "提现"
        } else if index == 2 {
            wallet.imgView.image = UIImage(named: "wallet_local")
            wallet.labView.text = "周边"
        } else {
            wallet.imgView.image = UIImage(named: "wallet_scan")
            wallet.labView.text = "扫码"
        }
        
        wallet.labView.textColor = UIColor.whiteColor()
        wallet.labView.font = UIFont.systemFontOfSize(autoSize(14, max: 16))
        return wallet
    }
    
    override func didMoveToSuperview() {
        if superview != nil {
            snp_makeConstraints(closure: { (make) in
                if index != 0 {
                    make.left.equalTo(superview!.snp_right).multipliedBy(CGFloat(index) * 0.3333)
                }
                make.width.equalTo(superview!).multipliedBy(0.333)
                make.height.equalTo(superview!)
            })
            addSubview(imgView)
            addSubview(labView)
            imgView.snp_makeConstraints(closure: { (make) in
                make.centerX.equalTo(self)
                make.centerY.equalTo(self).offset(-15)
                make.width.height.equalTo(40)
            })
            labView.snp_makeConstraints(closure: { (make) in
                make.centerX.equalTo(imgView)
                make.top.equalTo(imgView.snp_bottom).offset(10)
            })
        }
    }
    
    func touchEvent() {
        delegate?.onTouchEvent("header", index: index)
    }
}
