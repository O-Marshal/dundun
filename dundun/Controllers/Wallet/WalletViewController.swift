//
//  WalletViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Alamofire
import SnapKit
import SwiftyJSON

class WalletViewController: BaseViewController {
    
    let moneyView = WalletMoneyView()
    let chartView = WalletChartView()
    let btn2View = WalletBtn2WrapView()
    let scrollView = MScollView()
    let cellBtn = WalletCellButtonView()
    
    override func initView() {
        initHeaderView()
    }
    
    override func initEvent() {
        get("http://dundun.mog.name/active/home", identifier: "active")
        postWithLogin("http://dundun.mog.name/wallet", params: [:])
    }
    
    override func netErrorAuth() {
        
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if identifier == "active" {
            if let jsonArray = MJson.json(result).array {
                let strArr = jsonArray.map({ $0.description })
                scrollView.setData(strArr)
            }
            return
        }
        if let json = MJson.json(result).dictionary {
            moneyView.setData(json["m"]!.description)
            chartView.setData([
                ("盾盾卡卷", (json["m1"]?.floatValue.cfloatValue)!),
                ("基金返现", (json["m2"]?.floatValue.cfloatValue)!),
                ("系统分红", (json["m3"]?.floatValue.cfloatValue)!),
                ("邀请奖励", (json["m4"]?.floatValue.cfloatValue)!),
                ("签到奖励", (json["m5"]?.floatValue.cfloatValue)!)
                ])
        }
    }
}

extension WalletViewController {
    func initHeaderView() {
        let wrapView = UIView().withBack(MColor.themeColor).addTo(view)
        wrapView.snp_makeConstraints { (make) in
            make.width.equalTo(view)
            make.height.equalTo(80)
        }
        
        WalletHeaderView.headerView(0).setDelegate(self).addTo(wrapView)
        WalletHeaderView.headerView(1).setDelegate(self).addTo(wrapView)
        WalletHeaderView.headerView(2).setDelegate(self).addTo(wrapView)
        
        let scrollWrap = UIScrollView()
        scrollWrap.addTo(view).snp_makeConstraints { (make) in
            make.top.equalTo(wrapView.snp_bottom)
            make.width.left.right.equalTo(view)
            make.height.equalTo(view).offset(-80)
        }
        scrollWrap.addSubview(moneyView)
        scrollWrap.addSubview(chartView)
        
        btn2View.delegate = self
        scrollWrap.addSubview(btn2View)
        scrollWrap.addSubview(scrollView)
        
        cellBtn.delegate = self
        scrollWrap.addSubview(cellBtn)
        
        scrollWrap.contentSize = CGSize(width: 0, height: 640)
    }
}


// MARK: - 按钮回调事件
extension WalletViewController: MButtonEventIdentifyDelegate {
    func onTouchEvent(identify: String?) {
        if identify == "cell" {
            showViewController(WalletAccountTableView(), sender: nil)
        }
    }
    
    func onTouchEvent(identify: String?, index: Int) {
        if identify == "btn2" {
            if index == 1 {
                showViewController(WalletCardViewController(), sender: nil)
            } else {
                showViewController(WalletBillViewController(), sender: nil)
            }
        } else if identify == "header" {
            if index == 1 {
                showViewController(WalletCashViewController(), sender: nil)
            } else if index == 2 {
                navigationController?.pushViewController(LocalViewController(), animated: true)
            } else {
                showViewController(QRCodeViewController(), sender: nil)
            }
        }
    }
}
