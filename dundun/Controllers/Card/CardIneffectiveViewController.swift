//
//  CardIneffectiveViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class CardIneffectiveViewController: CardBaseViewController {

    let bindingDateView  = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        groupViewLayout(commercialNameView, referenceView: view)
        groupViewLayout(cardMonyView, referenceView: commercialNameView)
        //绑定日期 --
        view.addSubview(bindingDateView)
        view.createGroupSubView(bindingDateView, name: "绑定日期")
        groupViewLayout(bindingDateView, referenceView: cardMonyView)
        groupViewLayout(effectiveDateView, referenceView: bindingDateView)
        groupViewLayout(statusView, referenceView: effectiveDateView)
        //设置状态
        let statuaValue = statusView.viewWithTag(102) as! UILabel
        statuaValue.text = "未生效"
        statuaValue.textColor = UIColor.redColor()
    }


}
