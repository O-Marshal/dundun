//
//  PersonalAdrCellBtn.swift
//  dundun
//
//  Created by 刘荣 on 16/4/24.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class PersonalAdrCellBtn: UITableViewCell {
    
    let btn = UIButton()
    
    var void: (() -> Void)?
    
    func setTitle(title: String) {
        let title = NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: autoSize(16, max: 18))!, NSForegroundColorAttributeName: UIColor.whiteColor()])
        btn.setAttributedTitle(title, forState: .Normal)
    }
    
    func initView(void: (() -> Void)?) {
        
        selectionStyle = .None
        self.void = void
        let title = NSAttributedString(string: "保 存", attributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: autoSize(16, max: 18))!, NSForegroundColorAttributeName: UIColor.whiteColor()])
        btn.setAttributedTitle(title, forState: .Normal)
        btn.backgroundColor = MColor.themeColor
        backgroundColor = MColor.backgroundColor
        
        btn.addTarget(self, action: #selector(btnEvent), forControlEvents: .TouchUpInside)
        
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        addSubview(btn)
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        btn.snp_makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.height.equalTo(self)
            make.width.equalTo(self).multipliedBy(0.6)
        }
    }
    
    func btnEvent() {
        if let v = void {
            return v()
        }
    }

}
