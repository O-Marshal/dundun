//
//  ExtensionIndentView.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

let bgColor = UIColor(red: 0.93, green: 0.95, blue: 1.00, alpha: 1.00)
let themColor = UIColor(red: 0.4, green: 0.6, blue: 1, alpha: 1)
let blue = UIColor.blueColor()
let gray = UIColor.grayColor()
let white = UIColor.whiteColor()
let red = UIColor.redColor()
let labelFont = UIFont.boldSystemFontOfSize(autoSize(12, max: 14))



let grayClear =  UIColor(white: 0.8, alpha: 0.6)
extension  NSObject {
    // 创建订单流程view
    func createIndentFlow(view: UIView, colors: NSArray, tag: Int) {
        let indent = IndentFlowView()
        indent.tag = tag
        indent.line1Color = colors[4] as! UIColor
        indent.line2Color = colors[5] as! UIColor
        indent.line3Color = colors[6] as! UIColor
        view.addSubview(indent)
        indent.AffirmLabel.textColor = colors[0] as! UIColor
        indent.PayLabel.textColor = colors[1] as! UIColor
        indent.sellerDeliverLabel.textColor = colors[2] as! UIColor
        indent.AffirmReceiveLabel.textColor = colors[3] as! UIColor
        indent.backgroundColor = white
        indent.snp_makeConstraints { (make) in
            make.top.equalTo(view)
            make.width.equalTo(view)
            make.height.equalTo(70)
        }
    }
    
    func createIndentInfo(view: UIView, numberss: String, totalss: String, times: String) {
        let infoView = UIView()
        infoView.backgroundColor = white
        view.addSubview(infoView)
        infoView.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(85)
            make.width.equalTo(view)
            make.height.equalTo(140)
        }
        let number = UILabel()
        number.text = "订单编号:"
        number.font = labelFont
        infoView.addSubview(number)
        number.snp_makeConstraints { (make) in
            make.top.equalTo(infoView).offset(15)
            make.left.equalTo(infoView).offset(15)
        }
        let numbers = UILabel()
        numbers.text = numberss
        numbers.font = labelFont
        infoView.addSubview(numbers)
        numbers.snp_makeConstraints { (make) in
            make.top.equalTo(infoView).offset(15)
            make.left.equalTo(number.snp_right).offset(15)
        }
        let total = UILabel()
        total.text = "订单总额:"
        total.font = labelFont
        infoView.addSubview(total)
        total.snp_makeConstraints { (make) in
            make.bottom.equalTo(infoView).offset(-15)
            make.left.equalTo(infoView).offset(15)
        }
        let totals = UILabel()
        totals.font = labelFont
        totals.textColor = red
        totals.text = totalss
        infoView.addSubview(totals)
        totals.snp_makeConstraints { (make) in
            make.bottom.equalTo(infoView).offset(-15)
            make.left.equalTo(total.snp_right).offset(15)
        }
        
        let createTime = UILabel()
        createTime.font = labelFont
        createTime.text = "创建时间:"
        infoView.addSubview(createTime)
        createTime.snp_makeConstraints { (make) in
            make.top.equalTo(number.snp_bottom).offset(22)
            make.left.equalTo(infoView).offset(15)
        }
        let time = UILabel()
        time.text = times
        time.font = labelFont
        infoView.addSubview(time)
        time.snp_makeConstraints { (make) in
            make.top.equalTo(number.snp_bottom).offset(22)
            make.left.equalTo(createTime.snp_right).offset(15)
        }
        
        
    }
    func createAffimView(view: UIView?, tag: Int) -> UIView{
        let AffimView = UIView()
        AffimView.tag = tag
        view!.addSubview(AffimView)
        AffimView.snp_makeConstraints { (make) in
            make.bottom.equalTo(view!)
            make.width.equalTo(view!)
            make.height.equalTo(50)
        }
        return AffimView
    }
    
    func createRightView(affimView: UIView?, rightTitle: String?) -> UIButton{
        let rightView = UIButton(type: .Custom)
        rightView.backgroundColor = themColor
        rightView.titleLabel?.font = labelFont
        rightView.setTitle(rightTitle, forState: .Normal)
        affimView!.addSubview(rightView)
        
        rightView.snp_makeConstraints { (make) in
            make.right.equalTo(affimView!)
            make.left.equalTo(affimView!.snp_centerX)
            make.bottom.equalTo(affimView!)
            make.top.equalTo(affimView!)
        }
        
        return rightView
    }
    func creatLeftView(affimView: UIView?, leftTitle: String?, isCount: Bool, isBtn: Bool) -> UIView{
        
        if isBtn {
            let leftView = UIButton(type: .Custom)
            leftView.setTitleColor(themColor, forState: .Normal)
            leftView.titleLabel?.font = labelFont
            leftView.setTitle(leftTitle, forState: .Normal)
            leftView.backgroundColor = white
            
            affimView!.addSubview(leftView)
            leftView.snp_makeConstraints { (make) in
                make.left.equalTo(affimView!)
                make.right.equalTo(affimView!.snp_centerX)
                make.bottom.equalTo(affimView!)
                make.top.equalTo(affimView!)
            }
            return leftView
        }
        let leftView = UIView()
        leftView.backgroundColor = white
        affimView!.addSubview(leftView)
        leftView.snp_makeConstraints { (make) in
            make.left.equalTo(affimView!)
            make.right.equalTo(affimView!.snp_centerX)
            make.bottom.equalTo(affimView!)
            make.top.equalTo(affimView!)
        }
        
        let label1 = UILabel()
        label1.text = leftTitle
        label1.font = labelFont
        label1.textAlignment = .Right
        leftView.addSubview(label1)
        if !isCount {
            label1.snp_makeConstraints { (make) in
                make.top.equalTo(leftView).offset(15)
                make.centerX.equalTo(leftView.snp_centerX)
            }
            return label1
        }
        label1.snp_makeConstraints { (make) in
            make.top.equalTo(leftView).offset(15)
            make.right.equalTo(leftView.snp_centerX)
        }
        
        
        let label2 = UILabel()
        leftView.addSubview(label2)
        label2.textAlignment = .Left
        label2.textColor = red
        label2.font = labelFont
        label2.snp_makeConstraints { (make) in
            make.top.equalTo(leftView).offset(15)
            make.left.equalTo(leftView.snp_centerX).offset(5)
        }
        
        
        return label2
    }
}
