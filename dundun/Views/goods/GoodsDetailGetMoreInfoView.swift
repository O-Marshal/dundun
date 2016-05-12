//
//  GoodsDetailGetMoreInfoView.swift
//  dundun
//
//  Created by 刘荣 on 16/5/4.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class GoodsDetailGetMoreInfoView: UIView {
    
    let labView = UILabel()
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.width.equalTo(superview!)
            make.height.equalTo(100)
        }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
    }
    
    func setText(text: String) {
        labView.text = "---  \(text)  --"
    }
    
    private func initView() {
        labView.textColor = MColor.textLabelColor
        labView.font = UIFont(name: "Heiti SC", size: 14)
    }

}
