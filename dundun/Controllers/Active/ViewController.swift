//
//  ViewController.swift
//  mySwift
//
//  Created by students on 16/4/9.
//  Copyright © 2016年 王允顶. All rights reserved.
//

import UIKit

import SnapKit
//底色
let groundColour = UIColor.grayColor()
//控件所在的底色
let controlColour = UIColor.whiteColor()

class ViewController: BaseViewController {

    override func initView() {

        //盾盾卡卷
        self.setButton(CGRect(x: 200, y: 70, width: 150, height: 40), tag: 3, name: "盾盾卡卷")
        
        //返现
        self.setButton(CGRect(x: 200, y: 120, width: 150, height: 40), tag: 4, name: "返现")
        
        //签到
        self.setButton(CGRect(x: 200, y: 170, width: 150, height: 40), tag: 5, name: "签到")
        //邀请
        self.setButton(CGRect(x: 200, y: 220, width: 150, height: 40), tag: 6, name: "邀请")
        
        //定位
        self.setButton(CGRect(x: 200, y: 270, width: 150, height: 40), tag: 7, name: "高德地图定位")
    }
   
    //添加按键函数
    func setButton(frame :CGRect , tag : Int , name : String)
    {
        let btn = UIButton(frame: frame)
        self.view.addSubview(btn)
        btn.tag = tag
        btn.setTitle(name, forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(ViewController.buttonTouch(_:)), forControlEvents: .TouchUpInside)
    }
    //按键点击事件函数
    func buttonTouch(btn : UIButton)
    {
        switch btn.tag
        {
        case 3:
            let blockVC = BlockViewController()
            blockVC.navigationItem.title = "盾盾卡卷"
            self.navigationController!.pushViewController(blockVC, animated: true)
            break
        case 4:
            let returnVC = ReturnViewController()
            returnVC.navigationItem.title = "返现"
            self.navigationController?.pushViewController(returnVC, animated: true)
            break
        case 5:
            let signinVC = SignInViewController()
            signinVC.navigationItem.title = "签到"
            self.navigationController?.pushViewController(signinVC, animated: true)
            break
        case 6:
            let inviteVC = InviteViewController()
            inviteVC.navigationItem.title = "邀请"
            self.navigationController?.pushViewController(inviteVC, animated: true)
            break
//        case 7:
//            let amapVC = AMAPViewController()
//            amapVC.navigationItem.title = "定位"
//            self.navigationController?.pushViewController(amapVC, animated: true)
//            break
        default:
            break
            
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

