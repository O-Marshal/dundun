//
//  PayViewController.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
var numberss = String()
var times = String()
class PayViewController: BaseViewController {
    
    let black = UIColor.blackColor()
    
     var model = GoodsModel()
    
    override func initView() {
        title = "订单支付"
        let colors = [blue, blue, gray, gray, themColor, gray, gray]
        self.createIndentFlow(view, colors: colors, tag: 1002)
        
        self.createIndentInfo(view, numberss: numberss, totalss: amount, times: times)
        self.createPayWays()
        self.payBtn()
    }
    
    func payBtn()  {
        let payBtn = UIButton(type: .Custom)
        payBtn.backgroundColor = themColor
        payBtn.setTitle("货到付款", forState: .Normal)
        payBtn.titleLabel?.font = labelFont
        view.addSubview(payBtn)
        payBtn.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(100 + 140 + 250 + 30)
            make.left.equalTo(view).offset(30)
            make.right.equalTo(view).offset(-30)
            make.height.equalTo(70)
        }
       payBtn.withAction(self, selector: #selector(PayViewController.show))
        
    }
    func show() {
        postWithLogin("http://dundun.mog.name/order/pay", params: ["orderid" : numberss])
       
    }
    //  支付成功
    override func netSuccess(result: String, identifier: String?) {
        
        let indent = MyIndentController()
        showViewController(indent, sender: nil)
        
    }
    override func netError(errorType: AlamofireResultType, errorInfo: String, identifier: String?) {
        print("支付失败")
    }
    
    func createPayWays()  {
        let payView = UIView()
        payView.backgroundColor = white
        view.addSubview(payView)
        payView.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(100 + 140)
            make.width.equalTo(view)
            make.height.equalTo(250)
        }
        self.createPayHeader(payView)
    }
    
    func createPayHeader(payView: UIView)  {
        let header = UIView()
        payView.addSubview(header)
        header.snp_makeConstraints { (make) in
            make.top.equalTo(payView)
            make.width.equalTo(payView)
            make.height.equalTo(50)
        }
        let label = UILabel()
        label.text = "请选择支付方式"
        label.font = labelFont
        header.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.top.equalTo(header).offset(10)
            make.left.equalTo(header).offset(10)
        }
        
        let line = UIView()
        line.backgroundColor = black
        line.transform = CGAffineTransformMakeScale(1, 0.5)
        header.addSubview(line)
        line.snp_makeConstraints { (make) in
            make.bottom.equalTo(header)
            make.left.equalTo(header).offset(10)
            make.right.equalTo(header).offset(-10)
            make.height.equalTo(1)
        }
        
        
        
    }
}
