//
//  CardViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/12.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class CardBaseViewController: BaseViewController {

    let groundColor = UIColor(red: 0.93, green: 0.95, blue: 1.0, alpha: 1.0)
    let lineColor = UIColor(red: 0.94, green: 0.95, blue: 0.95, alpha: 1.0)
    /**commercialNameView 商户名称，cardMonyView 卡券金额 
       effectiveDateView 生效日期 statusView 状态
     */
    let commercialNameView = UIView()
    let cardMonyView = UIView()
    let effectiveDateView = UIView()
    let statusView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        //initBaseNavBar()
        initCommonNavBackItem()
        navigationItem.title = "盾盾卡券详情"
        view.backgroundColor = groundColor
        view.addSubview(commercialNameView)
        view.addSubview(cardMonyView)
        view.addSubview(effectiveDateView)
        view.addSubview(statusView)
        view.createGroupSubView(commercialNameView, name: "商户名称")
//        groupViewLayout(commercialNameView, referenceView: view)
        view.createGroupSubView(cardMonyView, name: "卡券金额")
        view.createGroupSubView(effectiveDateView, name: "生效日期")
        view.createGroupSubView(statusView, name: "状       态")
    }
    
    //创建superView的子视图
    func groupViewLayout(willLayoutView: UIView, referenceView: UIView){
        willLayoutView.snp_makeConstraints { (make) -> Void in
        if referenceView==view {
              make.top.equalTo(referenceView.snp_top).offset(10)
            }else{
              let line = UIView()
              line.backgroundColor = lineColor
              willLayoutView.addSubview(line)
              make.top.equalTo(referenceView.snp_bottom)
            }
            make.left.right.equalTo(referenceView)
            make.height.equalTo(60)
        }
        let nameLable = willLayoutView.viewWithTag(101) as! UILabel
        nameLable.font = UIFont.systemFontOfSize(15)
        nameLable.snp_makeConstraints { (make) -> Void in
            make.centerY.equalTo(willLayoutView)
            make.left.equalTo(willLayoutView)
            make.width.equalTo(80)
        }
        let valueLable = willLayoutView.viewWithTag(102) as! UILabel
        valueLable.snp_makeConstraints(closure: { (make) -> Void in
            make.centerY.equalTo(willLayoutView)
            //make.left.equalTo((nameLable.snp_right)!).offset(30)
            make.left.equalTo(nameLable.snp_right).offset(30)
        })
        if referenceView != view {
            let line = UIView()
            line.backgroundColor = lineColor
            willLayoutView.addSubview(line)
            line.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(referenceView.snp_bottom)
                make.left.equalTo(willLayoutView).offset(10)
                make.right.equalTo(willLayoutView)
                make.height.equalTo(2)
            })
        }
    }
}

extension UIView{
    
    func createGroupSubView(superView:UIView, name:String){
        superView.backgroundColor = UIColor.whiteColor()
        let nameLable = UILabel()
        nameLable.textAlignment = .Right
        nameLable.tag = 101
        nameLable.text = name
        superView.addSubview(nameLable)
        let valueLable = UILabel()
        valueLable.textAlignment = NSTextAlignment.Left
        valueLable.tag = 102
        valueLable.textColor = UIColor.grayColor()
        valueLable.text = "343434343"
        superView.addSubview(valueLable)
    }
    
}
