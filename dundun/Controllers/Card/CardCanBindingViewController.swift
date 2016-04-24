//
//  CardCanBindingViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/12.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class CardCanBindingViewController: CardBaseViewController {
 
    var bindingbtn:UIButton?
    let themColor = UIColor(red: 0.4, green: 0.6, blue: 1, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //view.createGroupSubView(commercialNameView, name: "商户名称")
        groupViewLayout(commercialNameView, referenceView: view)
        groupViewLayout(cardMonyView, referenceView: commercialNameView)
        groupViewLayout(effectiveDateView, referenceView: cardMonyView)
        groupViewLayout(statusView, referenceView: effectiveDateView)
        //设置状态
        let statuaValue = statusView.viewWithTag(102) as! UILabel
        statuaValue.text = "未绑定"
        statuaValue.textColor = UIColor.redColor()
        bindingbtn = UIButton(type:.Custom)
        
        bindingbtn?.backgroundColor = themColor
        bindingbtn?.setTitle("绑定", forState: .Normal)
        bindingbtn?.layer.masksToBounds = true
        bindingbtn?.layer.cornerRadius = 5
        view.addSubview(bindingbtn!)
        bindingbtnLayout(statusView)
    }
 
    func bindingbtnLayout(referenceView: UIView){
        bindingbtn?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(referenceView).offset(100)
            make.height.equalTo(40)
            make.centerX.equalTo(view)
            make.width.equalTo(250)
        })
    }
}
