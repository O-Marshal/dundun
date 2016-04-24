//
//  PersonalViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit

class PersonalViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    var model: PersonalModel?
    
    var img: UIImage?
    
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
        tableView.sectionHeaderHeight = 15
        loadData()
    }
    
    func loadData() {
        postWithLogin("http://dundun.mog.name/userInfo", params: [:])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        model = PersonalModel(jsonString: result)
        tableViewRelaod()
        print(model)
    }
    
}

// MARK: - TbaleView -
extension PersonalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:// 头像昵称
            let personalInfo = PersonalInfoSettingViewController()
            personalInfo.sex = model?.sex ?? 0
            personalInfo.nick = model?.nick
            personalInfo.imageCell.setImageString(model?.header)
            personalInfo.delegate = self
            showViewController(personalInfo, sender: nil)
        case 1:// 邀请签到
            return
        case 2:// 实名认证等等
            return
        case 3:// 系统设置等
            if indexPath.row == 0 {
                showViewController(PersonalSettingViewController(), sender: nil)
            }
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
            cell.setData(model?.header, nick: model?.nick)
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
            checkUserValidate(cell, indexPath: indexPath)
            return cell
        }
    }
    
    
}

// MARK: - 验证用户实名认证
extension PersonalViewController {
    func checkUserValidate(cell: PersonalIndexTableViewCell, indexPath: NSIndexPath) {
        if (indexPath.section == 2 && indexPath.row == 0) {
            if model?.vali?.idcard == nil {
                print(model?.vali)
                cell.setInfo("未认证")
            }
        }
    }
}
// MARK: - 处理资料更新回调事件
extension PersonalViewController: PersonalInfoSettingViewControllerProtocol {
    func onSuccess() {
        loadData()
    }
}
