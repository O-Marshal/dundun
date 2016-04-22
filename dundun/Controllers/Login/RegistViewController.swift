//
//  RegistViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/6.
//  Copyright © 2016年 Microali. All rights reserved.
//
import UIKit
import SnapKit
import SwiftyJSON


class RegistViewController: BaseViewController {
    
    
    let phoTextField = LoginTextFieldGroup()
    let smsTextField = LoginTextFieldGroup()
    let psdTextField = LoginTextFieldGroup()
    
    var smsBtn = UIButton()
    var btn = UIButton()
    
    var check: String = ""
    
    override func initView() {
        title = "注  册"
        view.backgroundColor = MColor.themeColor
        
        let logo = LogoView.defaultLogo().addTo(view)
        
        phoTextField.initGroup(logo, topOffset: autoSize(30, max: 60), icon: "tx_pho", placeholder: "请输入11位手机号码").addTo(view)
        smsTextField.initGroup(phoTextField, topOffset: autoSize(5, max: 10), icon: "tx_sms", placeholder: "请输入短信验证码").addTo(view)
        psdTextField.initGroup(smsTextField, topOffset: autoSize(5, max: 10), icon: "tx_psd", placeholder: "请设置 6 - 20 位密码").isPassword().addTo(view)
        
        
        smsBtn = MButton.whiteButton("获取验证码", target: self, action: #selector(sms)).addTo(view).btnView
        if MSize.defaultSize.isMinScreen {
            let attrTitle = NSAttributedString(string: "获取验证码", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14), NSForegroundColorAttributeName: MColor.themeColor])
            smsBtn.setAttributedTitle(attrTitle, forState: .Normal)
        }
        smsBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: autoSize(15, max: 20), bottom: 0, right: autoSize(15, max: 20))
        smsBtn.snp_makeConstraints { (make) in
            make.right.bottom.equalTo(phoTextField)
            make.height.equalTo(autoSize(30, max: 40))
        }
        
        btn = MButton.whiteButton("登       录", target: self, action: #selector(regist)).addTo(view).btnView
        btn.snp_makeConstraints { (make) in
            make.top.equalTo(psdTextField.snp_bottom).offset(autoSize(35, max: 50))
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
            make.height.equalTo(40)
        }
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if identifier == "sms" {
            check = result
            Notify.show(Whisper: "短信发送成功", theme: NotiTheme.Success, viewController: self)
            return Timer(count: 60, every: { (i) in
                self.smsBtn.setTitle("\(i)秒后再试", forState: .Normal)
            }) {
                self.smsBtn.setTitle("再次获取", forState: .Normal)
                self.smsBtn.enabled = true
            }.start()
        }
        Notify.show(Murmur: "注册成功，请登录", theme: NotiTheme.Success)
        dismissEvent()
    }
}

extension RegistViewController {
    
    func sms(sender: UIButton) {
        dismissKeyBoard(view)
        let userName = phoTextField.textFiled.text ?? ""
        if !validateUsername(userName) {
            return Notify.show(Whisper: "请输入正确的 11 位手机号码", theme: NotiTheme.Warring, viewController: self)
        }
        smsBtn.enabled = false
        get("http://dundun.mog.name/user/registsms/\(userName)", identifier: "sms")
    }
    
    func regist() {
        dismissKeyBoard(view)
        let userName = phoTextField.textFiled.text ?? ""
        let sms = smsTextField.textFiled.text ?? ""
        let passWord = psdTextField.textFiled.text ?? ""
        if !validateUsername(userName) {
            return Notify.show(Whisper: "请输入正确的 11 位手机号码", theme: NotiTheme.Warring, viewController: self)
        }
        if !validatePassword(passWord) {
            return Notify.show(Whisper: "密码长度应为 6 - 20 个字符", theme: NotiTheme.Warring, viewController: self)
        }
        if check.characters.count == 0 {
            return Notify.show(Whisper: "请获取手机验证码", theme: NotiTheme.Warring, viewController: self)
        }
        if sms.characters.count != 6 {
            return Notify.show(Whisper: "请输入6位手机验证码", theme: NotiTheme.Warring, viewController: self)
        }
        post("http://dundun.mog.name/user/regist", params: ["pho": userName, "sms": sms, "check": check, "psd": passWord], identifier: nil)
    }
    
    func validateUsername(username: String) -> Bool {
        return username.characters.count == 11
    }
    
    func validatePassword(password: String) -> Bool {
        return password.characters.count <= 20 && password.characters.count >= 6
    }
    
}
