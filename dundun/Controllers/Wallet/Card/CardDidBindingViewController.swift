//
//  CardDidBindingViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class CardDidBindingViewController: CardBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        groupViewLayout(commercialNameView, referenceView: view)
        groupViewLayout(cardMonyView, referenceView: commercialNameView)
        groupViewLayout(effectiveDateView, referenceView: cardMonyView)
        groupViewLayout(statusView, referenceView: effectiveDateView)
        let statuaValue = statusView.viewWithTag(102) as! UILabel
        statuaValue.text = "已绑定"
    }
}
