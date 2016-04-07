//
//  RegistViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/6.
//  Copyright © 2016年 Microali. All rights reserved.
//
import UIKit


class RegistViewController: UIViewController {
    
    let themColor = UIColor(red: 0.4, green: 0.6, blue: 1, alpha: 1)
    
    let phoTextField = LoginTextFieldGroup()
    let smsTextField = LoginTextFieldGroup()
    let psdTextField = LoginTextFieldGroup()
    
    
    override func viewDidLoad() {
        
        initBaseNavBar()
        initCommonNavBackItem()
        initView()
        title = "注  册"
        
        let logo = UILabel()
        logo.text = "DUNDUN"
        logo.font = UIFont.boldSystemFontOfSize(50)
        logo.textColor = UIColor.whiteColor()
        view.addSubview(logo)
        logo.snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(phoTextField.initGroup(logo, topOffset: 100, icon: "tx_pho"))
        view.addSubview(smsTextField.initGroup(phoTextField, topOffset: 10, icon: "tx_sms"))
        view.addSubview(psdTextField.initGroup(smsTextField, topOffset: 10, icon: "tx_psd"))
        
        
        
        let smsBtn = UIButton()
        smsBtn.setTitle("获取验证码", forState: .Normal)
        smsBtn.backgroundColor = UIColor.whiteColor()
        smsBtn.setTitleColor(themColor, forState: .Normal)
        view.addSubview(smsBtn)
        smsBtn.snp_makeConstraints { (make) in
            make.top.equalTo(phoTextField).offset(8)
            make.right.equalTo(phoTextField)
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        let btn = UIButton()
        btn.setTitle("注     册", forState: .Normal)
        btn.backgroundColor = UIColor.whiteColor()
        btn.setTitleColor(themColor, forState: .Normal)
        view.addSubview(btn)
        btn.snp_makeConstraints { (make) in
            make.top.equalTo(psdTextField.snp_bottom).offset(50)
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
}

extension RegistViewController {
    
    func initView() {
        view.backgroundColor = themColor
        
    }
    
    /**
     初始化公共NavgationBar样式
     */
    func initBaseNavBar() {
        let navbar = navigationController?.navigationBar
        navbar?.barTintColor = themColor
        navbar?.translucent = false
        //  渲染颜色
        navbar?.tintColor = UIColor.whiteColor()
        navbar?.barStyle = UIBarStyle.BlackTranslucent
        //  除去底部阴影细线
        navbar?.shadowImage = UIImage()
        navbar?.setBackgroundImage(UIImage(), forBarMetrics: .Default)
    }
    /**
     重写NavgationBar返回按钮样式
     */
    func initCommonNavBackItem() {
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .Plain, target: self, action: #selector(dismissEvent))
    }
}

//  渲染图片颜色
extension UIImage {
    func whiteImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, .Normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        CGContextClipToMask(context, rect, self.CGImage)
        UIColor.whiteColor().setFill()
        CGContextFillRect(context, rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}