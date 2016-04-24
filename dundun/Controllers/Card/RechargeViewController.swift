//
//  RechargeViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/12.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class RechargeViewController: BaseViewController {
   let groundColor = UIColor(red: 0.93, green: 0.95, blue: 1.0, alpha: 1.0)
   let lineColor = UIColor(red:0.95, green:0.96, blue:0.96, alpha:1.00)
   let moneyInputView = UIView()
   let payMethod = UIView()
    var sureButton:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        //initBaseNavBar()
        initCommonNavBackItem()
        navigationItem.title = "充值"
        view.backgroundColor = groundColor
        view.addSubview(moneyInputView)
        view.addSubview(payMethod)
        //金额输入框
        setMoneyInputSubViews(view)
        //支付方式选中
        setPayMethodSubViews(moneyInputView)
        //确认按钮
        setPaySureButton(payMethod)
    }
    
    func setMoneyInputSubViews(referenceView: UIView){
        moneyInputView.backgroundColor = UIColor.whiteColor()
        let title = UILabel()
        title.text = "充值金额"
        title.textAlignment = NSTextAlignment.Left
        title.font = UIFont.systemFontOfSize(15)
        moneyInputView.addSubview(title)
        let input = UITextField()
        input.font = UIFont.systemFontOfSize(14)
        input.placeholder = "请输入金额"
        moneyInputView.addSubview(input)
        moneyInputView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(referenceView).offset(10)
            make.left.right.equalTo(referenceView)
            make.height.equalTo(60)
        }
        title.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(moneyInputView)
            make.left.equalTo(moneyInputView).offset(10)
            make.width.equalTo(80)
        }
        input.snp_makeConstraints { (make) -> Void in
            make.top.bottom.equalTo(moneyInputView)
            make.left.equalTo(title.snp_right).offset(20)
        }
    }
    
    func setPayMethodSubViews(referenceView: UIView){
       payMethod.backgroundColor = UIColor.whiteColor()
        let title = UILabel()
        title.text = "请选择支付方式"
        title.textColor = UIColor.grayColor()
        title.textAlignment = NSTextAlignment.Left
        title.font = UIFont.systemFontOfSize(15)
        payMethod.addSubview(title)
        let line = UIView()
        line.backgroundColor = lineColor
        payMethod.addSubview(line)
        payMethod.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(referenceView.snp_bottom).offset(10)
            make.left.right.equalTo(referenceView)
            make.height.equalTo(160)
        }
        title.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(payMethod).offset(10)
        }
        line.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(title.snp_bottom).offset(20)
            make.left.equalTo(payMethod).offset(10)
            make.right.equalTo(payMethod).offset(-10)
            make.height.equalTo(2)
        }
        let weixin = MButton.defaultButton("微信支付", image: "cardvolume_zhifu_normal", action: #selector(RechargeViewController.weixinPay(_:)), target: self)
        weixin.setImage(UIImage(named: "cardvolume_zhifu_selected"), forState: .Selected)
        weixin.setTitleColor(UIColor.blackColor(), forState: .Normal)
        payMethod.addSubview(weixin)
        let zhifubao = MButton.defaultButton("支付宝支付", image: "cardvolume_zhifu_normal", action: #selector(RechargeViewController.zhifubaoPay(_:)), target: self)
        zhifubao.setTitleColor(UIColor.blackColor(), forState: .Normal)
        zhifubao.setImage(UIImage(named: "cardvolume_zhifu_selected"), forState: .Selected)
        payMethod.addSubview(zhifubao)
        setPayMethodButton(weixin,referenceView: line, icon: "cardvolume_weixin")
        setPayMethodButton(zhifubao,referenceView: weixin, icon: "cardvolume_zhifubao")
       
    }
    func setPayMethodButton(button:MButton, referenceView: UIView ,icon:String){
        let icon = UIImageView.init(image: UIImage(named: icon))
        button.addSubview(icon)
        button.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(referenceView)
            make.top.equalTo(referenceView.snp_bottom)
            make.height.equalTo(60)
        }
        button.initBack { () -> Void in
            button.imageEdgeInsets = UIEdgeInsets(top: 0, left:button.frame.size.width-20, bottom: 0, right: 0)
            button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -button.frame.size.width+130, bottom: 0, right: 0)
            button.titleLabel?.textAlignment = NSTextAlignment.Left
            icon.snp_makeConstraints(closure: { (make) -> Void in
                make.centerY.left.equalTo(button)
                make.width.equalTo(30)
            })
        }
    }
    
    func setPaySureButton(referenceView: UIView){
        let sureButton = UIButton(type: .Custom)
        sureButton.setTitle("确认", forState: .Normal)
        sureButton.layer.masksToBounds = true
        sureButton.layer.cornerRadius = 5
        sureButton.backgroundColor = UIColor.blueColor()
        view.addSubview(sureButton)
        sureButton.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(referenceView.snp_bottom).offset(20)
            make.centerX.equalTo(referenceView)
            make.width.equalTo(200)
        }
    }
    
    //MARK  支付
    func weixinPay(sender:UIButton){
      sender.selected = !sender.selected
      
    }
    func zhifubaoPay(sender:UIButton){
      sender.selected = !sender.selected
      
    }
    
    
}
