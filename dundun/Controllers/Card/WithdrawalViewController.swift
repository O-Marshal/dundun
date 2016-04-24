//
//  WithdrawalViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/12.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WithdrawalViewController: BaseViewController {

    let themColor = UIColor(red: 0.4, green: 0.6, blue: 1, alpha: 1)
    let groundColor = UIColor(red: 0.93, green: 0.95, blue: 1.0, alpha: 1.0)
    let countView = UIView()
    let moneyView = UIView()
    var surebtn:UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        //initBaseNavBar()
        initCommonNavBackItem()
        initRechargeNavBackItem()
        view.backgroundColor = groundColor
        navigationItem.title = "提现"
        //视图
        view.addSubview(countView)
        view.addSubview(moneyView)
        
        view.createGroupSubView(countView, name: "提现账号")
        view.createGroupSubView(moneyView, name: "可提现的金额")
        surebtn = UIButton(type: .Custom)
        view.addSubview(surebtn!)
        surebtn?.backgroundColor = themColor
        surebtn?.setTitle("确认", forState: .Normal)
        surebtn?.layer.masksToBounds = true
        surebtn?.layer.cornerRadius = 5
        groupViewLayout(countView, referenceView: view)
        groupViewLayout(moneyView, referenceView: countView)
        surebtnLayout(moneyView)
    }
  
    //创建superView的子视图
    func groupViewLayout(willLayoutView: UIView, referenceView: UIView){
        willLayoutView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(referenceView==view ? referenceView.snp_top:referenceView.snp_bottom).offset(10)
            make.left.right.equalTo(referenceView)
            make.height.equalTo(60)
        }
        
        let valueLable = willLayoutView.viewWithTag(102)
        valueLable?.snp_makeConstraints(closure: { (make) -> Void in
            make.left.equalTo(willLayoutView.snp_centerX).offset(-20)
            make.right.equalTo(willLayoutView).offset(20)
            make.centerY.equalTo(willLayoutView)
            
        })
        let nameLable = willLayoutView.viewWithTag(101)
        nameLable?.snp_makeConstraints { (make) -> Void in
            make.right.equalTo((valueLable?.snp_left)!).offset(-30)
            make.centerY.equalTo(willLayoutView)
        }
    }
    func surebtnLayout(referenceView: UIView){
        surebtn?.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(referenceView).offset(100)
            make.height.equalTo(40)
            make.centerX.equalTo(view)
            make.width.equalTo(250)
        })
    }
    
    func initRechargeNavBackItem() {
        let rigthBtn=UIButton(frame: CGRectMake(0, 0, 80, 25))
        rigthBtn.setTitle("修改账户", forState: .Normal)
        rigthBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rigthBtn)
    }
}
