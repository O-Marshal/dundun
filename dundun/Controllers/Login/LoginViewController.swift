//
//  LoginViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Whisper

class LoginViewController: BaseViewController {
    
    let themColor = MColor.themeColor
    
    
    let phoTextField = LoginTextFieldGroup()
    let psdTextField = LoginTextFieldGroup()
    
    override func initView() {
        initCommonNavBackItem("nav_close")
        title = "登录"
        
        let logo = LogoView.defaultLogo().addTo(view)
        phoTextField.initGroup(logo, topOffset: 60, icon: "tx_pho").addTo(view)
        psdTextField.initGroup(phoTextField, topOffset: 10, icon: "tx_psd").addTo(view)
        
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
        
        let scrollView = UIScrollView(frame: UIScreen.mainScreen().bounds)
        scrollView.addSubview(view)
        scrollView.contentSize = CGSize(width: 0, height: 700)
        scrollView.backgroundColor = themColor
        view = scrollView
        
    }
    
    func getLabel(title: String, action: Selector) -> UIButton {
        let btn = UIButton()
        btn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
        btn.setAttributedTitle(NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(12), NSForegroundColorAttributeName: UIColor.whiteColor()]), forState: .Normal)
        addsubView(btn)
        return btn
    }
    
    func regist() {
        showViewController(RegistViewController(), sender: nil)
    }
    func repass() {
        showViewController(RepassViewController(), sender: nil)
    }
    
    func touchEvent() {
//        myTimer = Timer.every(0.1, target: self, selector: #selector(myTimerEvent))
        
        showViewController(QRCodeViewController(), sender: nil)
        
    }
    var myTimer: NSTimer? = nil
    var i = 0
    func myTimerEvent() {
        print("啊实打实的马上离开:\(i)")
        i += 1
        if i == 5 {
            myTimer?.invalidate()
            print("休眠3秒")
            sleep(3)
            myTimer?.fire()
        }
    }

}
