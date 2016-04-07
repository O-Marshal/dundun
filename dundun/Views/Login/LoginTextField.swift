//
//  LoginTextField.swift
//  dundun
//
//  Created by 刘荣 on 16/4/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class LoginTextFieldGroup: UIView {
    
    
    private var topView: UIView?
    private var topOffset: CGFloat = 0
    private var icon = ""
    
    func initGroup(topView: UIView?, topOffset: CGFloat, icon: String) -> LoginTextFieldGroup {
        self.topView = topView
        self.topOffset = topOffset
        self.icon = icon
        //        self.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.1)
        return self
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        snp_makeConstraints { (make) in
            if topView == nil { make.top.equalTo(topOffset) } else { make.top.equalTo(topView!.snp_bottom).offset(topOffset) }
            make.left.equalTo(superview!).offset(20)
            make.right.equalTo(superview!).offset(-20)
            make.height.equalTo(60)
        }
        
        let iconView = UIImageView()
        iconView.image = UIImage(named: icon)
        addSubview(iconView)
        iconView.snp_makeConstraints { (make) in
            make.left.top.equalTo(self).offset(15)
            make.height.width.equalTo(30)
        }
        
        let textFiled = UITextField()
        textFiled.attributedPlaceholder = NSAttributedString(string: "请输入手机号码", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        textFiled.textColor = UIColor.whiteColor()
        textFiled.font = UIFont.boldSystemFontOfSize(18)
        addSubview(textFiled)
        textFiled.snp_makeConstraints { (make) in
            make.left.equalTo(iconView.snp_right).offset(10)
            make.top.height.equalTo(iconView)
            make.right.equalTo(self).offset(-10)
        }
        
        let lineView = UIView()
        addSubview(lineView)
        lineView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        //        lineView.transform = CGAffineTransformMakeScale(1, 0.5)
        lineView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.height.equalTo(0.5)
            make.bottom.equalTo(self).offset(-1)
        }
    }
}
