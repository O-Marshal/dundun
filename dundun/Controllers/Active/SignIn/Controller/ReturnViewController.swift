//
//  ReturnViewController.swift
//  mySwift
//
//  Created by students on 16/4/11.
//  Copyright © 2016年 王允顶. All rights reserved.
//

import UIKit

class ReturnViewController: BaseViewController {

    let moneyV = MoneyView()
    let rankingV = RankingView()
    let takeEffectV = RecordView()
    let boundV = RecordView()
    
    let myRecord = Record()
    let  myMoney = Money()
    let myRanking = Ranking()
    
    override func initView() {
        
        let urlStr = "http://dundun.mog.name/wallet/cash"
        self.postWithLogin(urlStr, params: [:])
        
        //设置Money界面
        self.setMoney()
        
        //设置Ranking界面
        self.setRanking()
        
        //设置卡卷生效记录界面
        self.setRecord()
        
        //设置卡卷绑定记录界面
        self.setBound()

    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //设置卡卷生效记录界面
    func setRecord()
    {
        self.view.addSubview(takeEffectV)
        takeEffectV.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(rankingV.snp_bottom).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(50)
            
        }
    }
    //设置卡卷绑定记录界面
    func setBound()
    {
        self.view.addSubview(boundV)
        boundV.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(takeEffectV.snp_bottom).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(50)
        }
        
            let record = Record()
            record.title = "返现记录"
            record.tag = 1
            boundV.record(record)
        
        let boundBtn = UIButton(type: UIButtonType.System)
        self.view.addSubview(boundBtn)
        boundBtn.snp_makeConstraints { (make) in
            
            make.top.equalTo(boundV).offset(0)
            make.left.equalTo(boundV).offset(0)
            make.right.equalTo(boundV).offset(0)
            make.bottom.equalTo(boundV).offset(0)
        }
        boundBtn.addTarget(self, action: #selector(ReturnViewController.boundBtnTouch), forControlEvents: .TouchUpInside)

    }
    //返现记录点击事件
    func boundBtnTouch()
    {
        print("返现记录")
    }
    
    //设置Ranking界面
    func setRanking()
    {
        
        self.view.addSubview(rankingV)
        rankingV.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(moneyV.snp_bottom).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(180)
            
        }

    }
    //设置Money界面
    func setMoney()
    {
        self.view.addSubview(moneyV)
        
        moneyV.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(90)
        }
        
    }
    
    override func netSuccess(result: String, identifier: String?) {
        
        let json = MJson.json(result)
        let dict = json.dictionaryValue
        
        myRecord.title = "系统分红"
        myRecord.num = dict["cash"]?.stringValue
        myRecord.tag = 0
        takeEffectV.record(myRecord)
        
        myMoney.totalStr = "累计返现"
        myMoney.totalInt = dict["total"]?.stringValue
        myMoney.returnStr = "昨日返现"
        myMoney.returnInt = dict["m0"]?.stringValue
        
        moneyV.money(myMoney)
        
        myRanking.upImage = "icon_star_highlight"
        myRanking.downImage = "icon_star_gray"
        myRanking.rankSrr = "活跃度"
        myRanking.star = dict["active"]?.floatValue
        myRanking.tag = 0
        rankingV.setRanking(myRanking)


    }
    

}
