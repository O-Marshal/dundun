//
//  PersonalViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit

class PersonalViewController: BaseViewController {
    
    let tableView = UITableView()
    var model: PersonalModel?
    
    let menus = [
        [
            (img: "user_auth", title: "实名认证"),
            (img: "user_list", title: "我的订单"),
            (img: "user_safe", title: "账号安全")
        ],
        [
            (img: "user_setting", title: "系统设置"),
            (img: "user_help", title: "用户帮助")
        ]
    ]
    
    override func initView() {
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        
        tableView.registerClass(PersonalIndexTableViewCell.classForCoder(), forCellReuseIdentifier: "default")
        tableView.registerClass(PersonalIndexTableViewCellHeader.classForCoder(), forCellReuseIdentifier: "header")
        tableView.registerClass(PersonalIndexTableViewCellSgin.classForCoder(), forCellReuseIdentifier: "sign")
        
        
        postWithLogin("http://dundun.mog.name/userInfo", params: [:])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        model = PersonalModel(jsonString: result)
    }
    
}

// MARK: - TbaleView -
extension PersonalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:// 头像昵称
            showViewController(PersonalInfoSettingViewController(), sender: nil)
        case 1:// 邀请签到
            return
        case 2:// 实名认证等等
            return
        case 3:// 系统设置等
            return
        default:
            return
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:// 头像昵称
            return 1
        case 1:// 邀请签到
            return 1
        case 2:// 实名认证等等
            return 3
        case 3:// 系统设置等
            return 2
        default:
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView().withBack(MColor.backgroundColor)
        hv.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 10)
        return hv
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 { return 80 }
        if indexPath.section == 1 { return 65 }
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:// 头像昵称
            let cell = tableView.dequeueReusableCellWithIdentifier("header") as! PersonalIndexTableViewCellHeader
            cell.initView()
            return cell
        case 1:// 邀请签到
            let cell = tableView.dequeueReusableCellWithIdentifier("sign") as! PersonalIndexTableViewCellSgin
            cell.initView()
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("default") as! PersonalIndexTableViewCell
            let menu = menus[indexPath.section - 2][indexPath.row]
            let line = menu == menus[0][2] || menu == menus[1][1] ? false : true
            cell.initView(menu.img, title: menu.title, line: line)
            return cell
        }
    }
    
    
}
