//
//  LoginTextField.swift
//  dundun
//
//  Created by 刘荣 on 16/4/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit

class LoginTextFieldGroup: UIView, UITextFieldDelegate {
    
    
    private var topView: UIView?
    private var topOffset: CGFloat = 0
    private var icon = ""
    private var placeholder = ""
    
    var value = ""
    
    
    func initGroup(topView: UIView?, topOffset: CGFloat, icon: String, placeholder: String = "请输入内容") -> LoginTextFieldGroup {
        self.topView = topView
        self.topOffset = topOffset
        self.icon = icon
        self.placeholder = placeholder
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
        textFiled.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        textFiled.textColor = UIColor.whiteColor()
        textFiled.font = UIFont.boldSystemFontOfSize(18)
        textFiled.delegate = self
        addSubview(textFiled)
        textFiled.snp_makeConstraints { (make) in
            make.left.equalTo(iconView.snp_right).offset(10)
            make.top.height.equalTo(iconView)
            make.right.equalTo(self).offset(-10)
        }
        
        addSubview(Line.defaultLine(0, color: MColor.lineLoginColor))
    }
}
