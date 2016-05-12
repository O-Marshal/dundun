//
//  GoodsInfoView.swift
//  dundun
//
//  Created by 刘荣 on 16/5/4.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class GoodsInfoView: UIView {
    
    var mHeight: CGFloat = 40
    
    private var topView = UIView()
    private let nameView = UILabel()
    private let priceView = UILabel()
    private let descView = UILabel()
    private let tagView = GoodsTagView()
    
    private let nameFont = UIFont(name: "Heiti SC", size: 20)
    private let priceFont = UIFont(name: "Heiti SC", size: 20)
    private let descFont = UIFont(name: "Heiti SC", size: 16)
    
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.top.equalTo(topView.snp_bottom).offset(10)
            make.width.equalTo(superview!)
            make.height.equalTo(mHeight)
        }
        nameView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        priceView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(nameView.snp_bottom).offset(10)
            make.left.right.equalTo(nameView)
        }
        descView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(priceView.snp_bottom).offset(10)
            make.left.right.equalTo(nameView)
        }
        
        let line = UIView().withBack(MColor.lineDefaultColor).addTo(self)
        line.snp_makeConstraints { (make) in
            make.top.equalTo(descView.snp_bottom).offset(10)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.height.equalTo(MSize.defaultSize.px(1))
        }
        tagView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(line.snp_bottom)
        }
        
    }
    
    private func initView() {
        backgroundColor = UIColor.whiteColor()
        descView.numberOfLines = 0
        
        nameView.textColor = MColor.textHeaderColor
        nameView.font = UIFont(name: "Heiti SC", size: 20)
        priceView.textColor = MColor.infoErrorColor
        priceView.font = UIFont.boldSystemFontOfSize(24)
        
        descView.textColor = MColor.textPlacholderColor
        descView.font = UIFont(name: "Heiti SC", size: 16)

    }
    
    
    func setData(model: GoodsModel) -> GoodsInfoView {
        
        let priceString = "￥ \(model.price)"
        
        nameView.text = model.name
        priceView.text = priceString
        descView.text = model.brief
        tagView.setTags(model.keywords)
        
        mHeight +=  model.name.sizeWithFont(nameFont).height
        mHeight += priceString.sizeWithFont(priceFont).height
        mHeight += model.brief.size(descFont, size: CGSize(width: MSize.defaultSize.width - 20, height: CGFloat.max)).height + 10
        mHeight += tagView.mHeight
        
        return self
    }
    
    func setTopView(top: UIView) -> GoodsInfoView {
        topView = top
        return self
    }

}
