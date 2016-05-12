//
//  WalletBtn2.swift
//  dundun
//
//  Created by 刘荣 on 16/4/29.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletBtn2WrapView: UIView {
    
    private let box1 = WalletBtnView()
    private let box2 = WalletBtnView()
    
    var delegate: MButtonEventIdentifyDelegate?
    
    override func didMoveToSuperview() {
        backgroundColor = UIColor.whiteColor()
        if superview == nil { return }
        
        snp_makeConstraints { (make) in
            make.top.equalTo(330)
            make.width.equalTo(superview!)
            make.height.equalTo(70)
        }
        
        box1.boxView("wallet_q", title: "盾盾卡卷").addTo(self)
        box2.boxView("wallet_f", title: "盾盾基金", secondView: true).addTo(self)
        
        box1.withAction(self, selector: #selector(touchEvent)).tag = 1
        box2.withAction(self, selector: #selector(touchEvent)).tag = 2
        
        
        let line = UIView().withBack(MColor.lineUserInfoColor).addTo(box1)
        line.snp_makeConstraints { (make) in
            make.right.centerY.equalTo(box1)
            make.height.equalTo(box1).multipliedBy(0.9)
            make.width.equalTo(1)
        }
    }
    
    func touchEvent(sender: UIButton) {
        delegate?.onTouchEvent("btn2", index: sender.tag)
    }
}


class WalletBtnView: UIButton {
    
    let imgView = UIImageView()
    let labView = UILabel()
    
    var secondView = false
    
    
    func boxView(img: String, title: String, secondView: Bool = false) -> WalletBtnView {
        imgView.image = UIImage(named: img)
        labView.text = title
        labView.textColor = MColor.textLabelColor
        self.secondView = secondView
        return self
    }
    
    override func didMoveToSuperview() {
        backgroundColor = UIColor.whiteColor()
        if superview == nil { return }
        
        snp_makeConstraints { (make) in
            make.width.equalTo(superview!).multipliedBy(0.5)
            make.centerY.equalTo(superview!)
            make.height.equalTo(40)
            if secondView {
                make.right.equalTo(superview!)
            } else {
                make.left.equalTo(superview!)
            }
        }
        
        imgView.addTo(self)
        labView.addTo(self)
        
        imgView.snp_makeConstraints { (make) in
            make.centerY.equalTo(self)
            make.centerX.equalTo(self).offset(-50)
            make.width.height.equalTo(40)
        }
        
        labView.snp_makeConstraints { (make) in
            make.left.equalTo(imgView.snp_right).offset(20)
            make.centerY.equalTo(self)
        }
    }
    
}
