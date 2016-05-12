//
//  GoodsTagView.swift
//  dundun
//
//  Created by 刘荣 on 16/5/4.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class GoodsTagView: UIView {
    
    var mHeight: CGFloat = 30
    
    private let labView = UILabel()
    private let lab = "商品标签："
    
    private let font = UIFont(name: "Heiti SC", size: 14)
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.left.right.equalTo(superview!)
        }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(15)
        }
        
    }
    
    private func initView() {
        labView.textColor = MColor.textLabelColor
        labView.font = font
        labView.text = lab
    }
    
    func setTags(tagString: String) {
        let tags = tagString.split("|")
        
        let labSize = lab.sizeWithFont(font)
        let defaultX = labSize.width + 20
        mHeight = labSize.height + 30
        
        var x: CGFloat = defaultX
        var y: CGFloat = 10
        
        for tag in tags {
            
            let tagSize = tag.sizeWithFont(font)
            var labelFrame = CGRect(x: x, y: y, width: tagSize.width + 20, height: tagSize.height + 10)
            
            // 如果label太长
            if labelFrame.size.width + defaultX + 10 > MSize.defaultSize.width {
                labelFrame.size.width = MSize.defaultSize.width - defaultX - 10
            }
            
            // 判断当前行剩余宽度是否能容纳当前标签
            if x + 5 + labelFrame.width > MSize.defaultSize.width - 20  {
                // 如果不能容纳，则换行
                x = defaultX
                y += labelFrame.height + 10
                labelFrame.origin.x = x
                labelFrame.origin.y = y
                
                mHeight += labelFrame.height + 10
            }
            
            
            let tagLabel = UILabel(frame: labelFrame)
            tagLabel.font = font
            tagLabel.textColor = UIColor.whiteColor()
            tagLabel.text = tag
            tagLabel.backgroundColor = UIColor(red: 0.7, green: 0.7, blue: 0.7, alpha: 0.6)
            tagLabel.layer.cornerRadius = 3
            tagLabel.clipsToBounds = true
            tagLabel.textAlignment = .Center
            addSubview(tagLabel)
            
            x += 10 + labelFrame.width
        }
        
    }

}
