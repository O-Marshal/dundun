//
//  BlockViewController.swift
//  mySwift
//
//  Created by 王 on 16/4/10.
//  Copyright © 2016年 王允顶. All rights reserved.
//

import UIKit



class BlockViewController: BaseViewController {

    let moneyV = MoneyView()
    let rankingV = RankingView()
    let takeEffectV = RecordView()
    let boundV = RecordView()
    
    let  myMoney = Money()
    let myRanking = Ranking()
    
    override func initView() {

        let urlStr = "http://dundun.mog.name/wallet/card"
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
        
            let record = Record()
            record.title = "卡卷生效记录"
            record.tag = 1
            takeEffectV.record(record)
        
        let takeEffectBtn = UIButton(type: UIButtonType.System)
        self.view.addSubview(takeEffectBtn)
        takeEffectBtn.snp_makeConstraints { (make) in
            
            make.top.equalTo(takeEffectV).offset(0)
            make.left.equalTo(takeEffectV).offset(0)
            make.right.equalTo(takeEffectV).offset(0)
            make.bottom.equalTo(takeEffectV).offset(0)
        }
        takeEffectBtn.addTarget(self, action: #selector(BlockViewController.takeEffectBtnTouch), forControlEvents: .TouchUpInside)
    }
    //卡卷生效记录点击事件
    func takeEffectBtnTouch()
    {
        print("卡卷生效记录")
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
        record.title = "卡卷绑定记录"
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
        boundBtn.addTarget(self, action: #selector(BlockViewController.boundBtnTouch), forControlEvents: .TouchUpInside)
        
    }
    
    func boundBtnTouch()
    {
        print("卡卷绑定记录")
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
    
    //重写代理函数
    override func netSuccess(result: String, identifier: String?) {
        
        let json = MJson.json(result)
        
        let dict = json.dictionaryValue

        myMoney.totalStr = "资产总额"
        myMoney.totalInt = dict["total"]?.stringValue
        myMoney.returnStr = "返现总额"
        myMoney.returnInt = dict["cash"]?.stringValue
        moneyV.money(myMoney)
        
        myRanking.downImage = "icon_rank"
        myRanking.upImage = dict["rank"]?.stringValue
        myRanking.rankSrr = "当前排名"
        myRanking.tag = 1
        rankingV.setRanking(myRanking)
        
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

}
