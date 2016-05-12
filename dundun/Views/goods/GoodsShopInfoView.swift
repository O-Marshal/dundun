//
//  GoodsShopInfoView.swift
//  dundun
//
//  Created by 刘荣 on 16/5/4.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Kingfisher

class GoodsShopInfoView: UIView {
    
    let mHeight: CGFloat = 200
    
    var delegate: MButtonEventIdentifyDelegate?
    var pid = 0
    
    private let firstLabel = UILabel()
    private let wrapView = UIView()
    private let logoView = UIImageView()
    private let labView = UILabel()
    
    private let btnShop = UIButton()
    private let btnPart = UIButton()
    
    private var topView = UIView()
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.top.equalTo(topView.snp_bottom).offset(20)
            make.width.equalTo(superview!)
            make.height.equalTo(mHeight)
        }
        firstLabel.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.centerX.equalTo(self)
        }
        let line = UIView().withBack(MColor.lineDefaultColor)
        line.addTo(self).snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(firstLabel.snp_bottom).offset(20)
            make.width.equalTo(firstLabel).multipliedBy(0.8)
            make.height.equalTo(1)
        }
        
        wrapView.addTo(self).snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(line.snp_bottom).offset(20)
            make.height.equalTo(50)
        }
        logoView.addTo(wrapView).snp_makeConstraints { (make) in
            make.top.left.equalTo(wrapView).offset(5)
            make.width.height.equalTo(40)
        }
        labView.addTo(wrapView).snp_makeConstraints { (make) in
            make.centerY.equalTo(wrapView)
            make.left.equalTo(logoView.snp_right).offset(5)
            make.right.equalTo(wrapView).offset(-15)
        }
        
        btnShop.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(wrapView.snp_bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self).offset(60)
        }
        btnPart.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(wrapView.snp_bottom).offset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalTo(self).offset(-60)
        }
        
    }
    
    private func initView() {
        backgroundColor = UIColor.whiteColor()
        firstLabel.text = "这件商品来自："
        firstLabel.textColor = MColor.textHeaderColor
        firstLabel.font = UIFont(name: "Heiti SC", size: 14)
        
        wrapView.clipsToBounds = true
        wrapView.layer.borderColor = MColor.lineDefaultColor.CGColor
        wrapView.layer.borderWidth = 1
        wrapView.layer.cornerRadius = 25
        
        logoView.clipsToBounds = true
        logoView.layer.cornerRadius = 20
        
        labView.textColor = MColor.textLabelColor
        labView.font = UIFont(name: "Heiti SC", size: 16)
        
        setBtn(btnShop.withAction(self, selector: #selector(onTouchShop)), title: "进入店铺")
        setBtn(btnPart.withAction(self, selector: #selector(onTouchPart)), title: "商家圈子")
    }
    
    private func setBtn(btn: UIButton, title: String) {
        btn.setTitle(title, forState: .Normal)
        let atrString = NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: 14)!, NSForegroundColorAttributeName: MColor.textHeaderColor])
        btn.setAttributedTitle(atrString, forState: .Normal)
        
        btn.backgroundColor = UIColor.whiteColor()
        btn.clipsToBounds = true
        btn.layer.borderColor = MColor.lineDefaultColor.CGColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 3
    }
    
    
    func onTouchShop() {
        delegate?.onTouchEvent("shop")
    }
    func onTouchPart() {
        delegate?.onTouchEvent("part")
    }
    
    
    func setTopView(top: UIView) -> GoodsShopInfoView {
        topView = top
        return self
    }
    
    func setData(name: String, logo: String) {
        logoView.kf_setImageWithURL(NSURL(string: logo)!, placeholderImage: UIImage(named: "icon_imageLoading"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        labView.text = name
    }

}
