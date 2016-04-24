//
//  SignInViewController.swift
//  mySwift
//
//  Created by students on 16/4/11.
//  Copyright © 2016年 王允顶. All rights reserved.
//

import UIKit

class SignInViewController: BaseViewController {

    let signInV = MoneyView()
    let recordV = RecordView()
    let  myMoney = Money()
    
    let btn = UIButton(type: UIButtonType.Custom)
    
    override func initView() {
        
        //请求数据
        let urlStr = "http://dundun.mog.name/wallet/sign"
        self.postWithLogin(urlStr, params: [:])
        
        //设置签到界面
        self.setSignIn()
        
        //设置Record界面
        self.setRecord()
        
        //设置签到按键
        self.setButton()

    }
    

    func setButton()
    {
        
        self.view.addSubview(btn)
        btn.setTitle("签到", forState: UIControlState.Normal)
        btn.setTitle("今日已签到", forState: UIControlState.Disabled)
        btn.addTarget(self, action: #selector(SignInViewController.btnTouch), forControlEvents: .TouchUpInside)
        btn.backgroundColor = UIColor.blueColor()
        btn.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(view).offset(0)
            make.height.equalTo(49)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
        }
    }
    //签到事件
    func btnTouch()
    {
        self.postWithLogin("http://dundun.mog.name/wallet/signactive", params: [:])
        btn.enabled = false
        btn.backgroundColor = UIColor.grayColor()
    }
    
    //设置Record界面
    func setRecord()
    {
        self.view.addSubview(recordV)
        recordV.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(signInV.snp_bottom).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(50)
        }
        
            let record = Record()
            record.title = "签到记录"
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
        recordBtn.addTarget(self, action: #selector(SignInViewController.recordBtnTouch), forControlEvents: .TouchUpInside)
                
    }

    //设置签到记录
    func recordBtnTouch()
    {
        print("签到记录")
    }
    
    //设置签到界面
    func setSignIn()
    {
        self.view.addSubview(signInV)
        
        signInV.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(0)
            make.right.equalTo(view).offset(0)
            make.height.equalTo(90)
        }
    }

    override func netSuccess(result: String, identifier: String?) {
        
        let json = MJson.json(result)
        let dict = json.dictionaryValue
        
        let b : Int = (dict["type"]?.intValue)!
        if b == 1
        {
            btn.enabled = false
            //btn.backgroundColor = UIColor(red: 80, green: 118, blue: 244, alpha: 1.0)
            btn.backgroundColor = UIColor.grayColor()
        }
        
        myMoney.totalStr = "签到天数"
        myMoney.totalInt = dict["day"]?.stringValue
        myMoney.returnStr = "签到收入"
        myMoney.returnInt = dict["money"]?.stringValue
        signInV.money(myMoney)

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
