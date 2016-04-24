//
//  HomePageViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/10.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class HomePageViewController: BaseViewController, HomePageViewDlegate{

    let homeUrl = "http://dundun.mog.name/active/home"
    let walletUrl = "http://dundun.mog.name/wallet"
    let walletListUrl = "http://dundun.mog.name/wallet/list"
    var homePageView:HomePageView?
    override func initView() {
        let h = (self.tabBarController?.tabBar.frame.height)! + self.navigationController!.navigationBar.frame.height + 20
        let homeViewFrame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height-h)
        let homePageView = HomePageView(frame:homeViewFrame, superView:self.view)
        self.homePageView = homePageView
        homePageView.delegate = self
        view.addSubview(homePageView)
        view.backgroundColor = UIColor.whiteColor()
    }
    
    override func initEvent() {
        get(homeUrl,identifier: "home")
        postWithLogin(walletUrl, params: [:], identifier: "wallet")
    }
    override func netSuccess(result: String, identifier: String?) {
        if identifier == "home" {
            homePageView?.setAdvertisemImageNames(AdvertisemImageNameModel.defaultAdvertisemImageNameModel(result))
        }
        if identifier == "wallet" {
            homePageView?.setWalleHometData(WalletHomeModel(jsonString: result))
        }
        if identifier == "wallletList" {
            var list = WalletList.defaultWalletList(result)
            print(list)
            navigationController?.pushViewController(TestBillTableViewController(), animated: false)
        }
        
    }
    
    //MARK
    func homePageViewDidWithdrawal(){
       navigationController?.pushViewController(WithdrawalViewController(), animated: false)
    }
    func homePageViewDidRecharge(){
      navigationController?.pushViewController(RechargeViewController(), animated: false)
    }
    func homePageViewDidCard(){
       //navigationController?.pushViewController(CardCanBindingViewController(), animated: false)
        navigationController?.pushViewController(TestCardTableViewController(), animated: false)
    }
    func homePageViewDidCashback(){
       navigationController?.pushViewController(ScanViewController(), animated: false)
    }
    func homePageViewDidObvious(){
        post(walletListUrl, params: ["page":"1"], identifier: "wallletList")
      //navigationController?.pushViewController(BillViewController(), animated: false)
        navigationController?.pushViewController(TestBillTableViewController(), animated: false)
    }
    func homePageViewDidScan(){}
}
