//
//  GoodsCollectionViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/25.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Kingfisher

class GoodsCollectionViewCell: UICollectionViewCell {
    
    let imgView = UIImageView().m_AspectFillImageView
    let labView = UILabel()
    let priceView = UILabel()
    
    func initView(model: GoodsModel) {
        imgView.kf_setImageWithURL(NSURL(string: model.thumb)!, placeholderImage: UIImage(named: "icon_imageLoading"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        labView.text = model.name
        priceView.text = "￥ \(model.price)"
    }
    
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        imgView.addTo(self).frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        labView.addTo(self).frame = UIEdgeInsetsInsetRect(CGRect(x: 0, y: frame.width, width: frame.width, height: 30), UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10))
        priceView.addTo(self).frame = UIEdgeInsetsInsetRect(CGRect(x: 0, y: frame.width + 30, width: frame.width, height: 30), UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        let popLine = UIImageView(image: UIImage(named: "pop_line"))
        popLine.addTo(self).frame = CGRect(x: 0, y: frame.width, width: frame.width, height: MSize.defaultSize.px(1))
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: 18)
        priceView.textColor = MColor.infoErrorColor
        priceView.font = UIFont.boldSystemFontOfSize(16)
        
        
        
        backgroundColor = UIColor.whiteColor()
    }

}
