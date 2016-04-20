//
//  FeedBackViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController {
    
    override func viewDidLoad() {
        initCommonNavBackItem()
        
        view.backgroundColor = MColor.backgroundColor
        title = "用户反馈"
        
        initFeedBackView()
    }
    
    func initFeedBackView() {
        let wrapView = UIView()
        let label1 = UILabel()
        let label2 = UILabel()
        let label3 = UILabel()
        let textType = UITextField()
        let textMsg = UITextView()
        let textInfo = UITextField()
        let btn = UIButton()
        
        let line1 = UIView()
        let line2 = UIView()
        
        addsubView(wrapView)
        addsubView(label1)
        addsubView(label2)
        addsubView(label3)
        addsubView(textType)
        addsubView(textMsg)
        addsubView(textInfo)
        addsubView(btn)
        
        addsubView(line1)
        addsubView(line2)
        
        wrapView.backgroundColor = UIColor.whiteColor()
        setLabels([label1, label2, label3])
        setLines([line1, line2], wrapView: wrapView)
        
        label1.text = "反馈类型："
        label2.text = "反馈内容："
        label3.text = "联系方式："
        
        textInfo.attributedPlaceholder = NSAttributedString(string: "电话/邮箱", attributes: [NSForegroundColorAttributeName: MColor.textPlacholderColor])
        
        textType.text = "支付问题"
        textType.font = UIFont.boldSystemFontOfSize(16)
        textType.textColor = MColor.textLabelColor
        
        btn.setTitle("提     交", forState: .Normal)
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.backgroundColor = MColor.themeColor
        
        wrapView.snp_makeConstraints { (make) in
            make.top.equalTo(5)
            make.left.right.equalTo(0)
            make.bottom.equalTo(label3).offset(20)
        }
        
        label1.snp_makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(wrapView).offset(20)
            make.width.equalTo(80)
        }
        textType.snp_makeConstraints { (make) in
            make.left.equalTo(label1.snp_right).offset(10)
            make.top.equalTo(label1)
            make.right.equalTo(wrapView).offset(-20)
        }
        line1.snp_makeConstraints { (make) in
            make.top.equalTo(label1.snp_bottom).offset(15)
        }
        
        
        label2.snp_makeConstraints { (make) in
            make.left.equalTo(label1)
            make.top.equalTo(line1.snp_bottom).offset(15)
            make.width.equalTo(label1)
        }
        textMsg.snp_makeConstraints { (make) in
            make.left.equalTo(label2.snp_right).offset(10)
            make.top.equalTo(label2)
            make.right.equalTo(wrapView).offset(-20)
            make.height.equalTo(150)
        }
        line2.snp_makeConstraints { (make) in
            make.top.equalTo(textMsg.snp_bottom).offset(15)
        }
        
        label3.snp_makeConstraints { (make) in
            make.left.equalTo(label1)
            make.top.equalTo(line2.snp_bottom).offset(15)
            make.width.equalTo(label1)
        }
        textInfo.snp_makeConstraints { (make) in
            make.left.equalTo(label3.snp_right).offset(10)
            make.top.equalTo(label3)
            make.right.equalTo(wrapView).offset(-20)
        }
        
        btn.snp_makeConstraints { (make) in
            make.left.equalTo(45)
            make.right.equalTo(-45)
            make.height.equalTo(50)
            make.top.equalTo(wrapView.snp_bottom).offset(30)
        }
        
        
    }
    
    func setLabels(labels: [UILabel]) {
        for label in labels {
            label.font = UIFont.systemFontOfSize(16)
            label.textColor = MColor.textLabelColor
        }
    }
    func setLines(lines: [UIView], wrapView: UIView) {
        for line in lines {
            line.snp_makeConstraints(closure: { (make) in
                make.left.equalTo(wrapView).offset(10)
                make.right.equalTo(wrapView).offset(-10)
                make.height.equalTo(MSize.defaultSize.px(1))
            })
            line.backgroundColor = MColor.lineDefaultColor
        }
    }

}
