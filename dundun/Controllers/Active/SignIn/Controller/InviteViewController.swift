//
//  InviteViewController.swift
//  mySwift
//
//  Created by students on 16/4/11.
//  Copyright © 2016年 王允顶. All rights reserved.
//

import UIKit

class InviteViewController: BaseViewController {

    let inviteV = MoneyView()
    let myInviteV = RecordView()
    let recordV = RecordView()
    
    let myRecord = Record()
    let  myMoney = Money()
    
    override func initView() {

        let urlStr = "http://dundun.mog.name/wallet/invite"
        self.postWithLogin(urlStr, params: [:])
        
        //设置邀请界面
        self.setInvite()
        
        //我的邀请码
        self.myInvite()
        
        //邀请记录
        self.record()

        
    }
    
   
    //邀请记录
    func record()
    {
        self.view.addSubview(recordV)
        recordV.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(myInviteV.snp_bottom).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(50)
        }
        
            let record = Record()
            record.title = "邀请记录"
            record.tag = 1
            recordV.record(record)
        
        let recordBtn = UIButton(type: UIButtonType.System)
        self.view.addSubview(recordBtn)
        recordBtn.snp_makeConstraints { (make) in
            
            make.top.equalTo(recordV).offset(0)
            make.left.equalTo(recordV).offset(0)
            make.right.equalTo(recordV).offset(0)
            make.bottom.equalTo(recordV).offset(0)
        }
        recordBtn.addTarget(self, action: #selector(InviteViewController.recordBtnTouch), forControlEvents: .TouchUpInside)

    }
    //邀请记录点击事件
    func recordBtnTouch()
    {
        print("邀请记录")
    }
    
    //我的邀请码
    func myInvite()
    {
        self.view.addSubview(myInviteV)
        myInviteV.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(inviteV.snp_bottom).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(50)
            
        }

    }
    
    //重写代理函数
    override func netSuccess(result: String, identifier: String?) {
        
        let json = MJson.json(result)
        let dict = json.dictionaryValue
        
        myMoney.totalStr = "邀请人数"
        myMoney.totalInt = dict["peopel"]?.stringValue
        myMoney.returnStr = "邀请收入"
        myMoney.returnInt = dict["money"]?.stringValue
        
        inviteV.money(myMoney)
        
        myRecord.title = "我的邀请码"
        myRecord.num = dict["code"]?.stringValue
        myRecord.tag = 0
        myInviteV.record(myRecord)
    }
    
    //设置邀请界面
    func setInvite()
    {
        self.view.addSubview(inviteV)
        
        inviteV.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(90)
        }
        
    }

    
  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
