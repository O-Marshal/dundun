//
//  LoginViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Whisper
import SwiftyJSON


class LoginViewController: BaseViewController {
    
    let themColor = MColor.themeColor
    
    
    let phoTextField = LoginTextFieldGroup()
    let psdTextField = LoginTextFieldGroup()
    
    override func initView() {
        initCommonNavBackItem("nav_close")
        title = "登录"
        
        let logo = LogoView.defaultLogo().addTo(view)
        phoTextField.initGroup(logo, topOffset: 60, icon: "tx_pho", placeholder: "请输入 11 位手机号码").addTo(view)
        psdTextField.initGroup(phoTextField, topOffset: 10, icon: "tx_psd", placeholder: "请输入密码").isPassword().addTo(view)
        
        let labelRepass = getLabel("忘记密码？", action: #selector(repass))
        let labelRegist = getLabel("用户注册", action: #selector(regist))
        labelRepass.snp_makeConstraints { (make) in
            make.top.equalTo(psdTextField.snp_bottom).offset(5)
            make.left.equalTo(view).offset(25)
        }
        labelRegist.snp_makeConstraints { (make) in
            make.top.equalTo(psdTextField.snp_bottom).offset(5)
            make.right.equalTo(view).offset(-25)
        }
        
        
        let btn = MButton.whiteButton("登       录", target: self, action: #selector(touchEvent)).addTo(view)
        btn.snp_makeConstraints { (make) in
            make.top.equalTo(psdTextField.snp_bottom).offset(70)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
            make.height.equalTo(50)
        }
        
        changeScrollView()
    }
    
    override func netSuccess(result: String, identifier: String?) {
        let json = JSON(data: result.dataUsingEncoding(NSUTF8StringEncoding)!)
        LoginController.userSave(json["userId"].intValue, token: json["token"].stringValue)
        Notify.show(Murmur: "登录成功", theme: NotiTheme.Success)
        print(LoginController.userInfo())
        dismissEvent()
    }
    
    override func netErrorCheck(errorData: String, identifier: String?) {
        Notify.show(Whisper: errorData, theme: NotiTheme.Warring, viewController: self)
    }
    
    override func netError(errorType: AlamofireResultType, errorInfo: String, errorData: String?, identifier: String?) {
        Notify.show(Whisper: errorInfo, theme: NotiTheme.Warring, viewController: self)
    }
}

//MARK: - 处理事件 -
extension LoginViewController{
    
    func regist() {
        showViewController(RegistViewController(), sender: nil)
    }
    func repass() {
        showViewController(RepassViewController(), sender: nil)
    }
    
    func touchEvent() {
        let userName = phoTextField.textFiled.text ?? ""
        let passWord = psdTextField.textFiled.text ?? ""
        if !validateUsername(userName) {
            return Notify.show(Whisper: "请输入正确的 11 位手机号码", theme: NotiTheme.Warring, viewController: self)
        }
        if !validatePassword(passWord) {
            return Notify.show(Whisper: "密码长度应为 6 - 20 个字符", theme: NotiTheme.Warring, viewController: self)
        }
        post("http://dundun.mog.name/user/login", params: ["pho": userName, "psd": passWord])
    }
    
    
    
    func validateUsername(username: String) -> Bool {
        return username.characters.count == 11
    }
    
    func validatePassword(password: String) -> Bool {
        return password.characters.count <= 20 && password.characters.count >= 6
    }
    
    func getLabel(title: String, action: Selector) -> UIButton {
        let btn = UIButton()
        btn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        btn.setAttributedTitle(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.whiteColor()]), forState: .Normal)
        addsubView(btn)
        return btn
    }
}
