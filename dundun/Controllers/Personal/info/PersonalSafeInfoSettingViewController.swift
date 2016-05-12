//
//  PersonalSafeInfoSettingViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalSafeInfoSettingViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    
    var img: UIImage?
    var nick: String?
    var sex = 0
    
    typealias safeInfoType = (img: String, lab: String, bind: Bool)
    var datas: [safeInfoType] = [
        ("share_qq", "绑定QQ", false),
        ("share_sinaweibo", "绑定新浪微博", false)
    ]
    
    
    var delegate: PersonalInfoSettingViewControllerProtocol?
    
    let textFieldcell = PersonalInfoCellTextField()
    let imageCell = PersonalInfoCellHeader()
    
    override func initView() {
        title = "安全中心"
        
        tableView.separatorStyle = .None
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(PersonalIndexTableViewCell.classForCoder(), forCellReuseIdentifier: "safe")
        
        postWithLogin("http://dundun.mog.name/userInfo/oauthlist", params: [:])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if identifier == "qq" {
            Notify.show(Whisper: "QQ绑定成功", theme: NotiTheme.Success, viewController: self)
            datas[0].bind = true
            tableView.reloadData()
        } else if identifier == "weibo" {
            Notify.show(Whisper: "新浪微博绑定成功", theme: NotiTheme.Success, viewController: self)
            datas[1].bind = true
            tableView.reloadData()
        } else {
            if let items = MJson.json(result).array {
                for item in items {
                    if item["plam"].stringValue == "qq" {
                        datas[0].bind = true
                    } else if item["plam"].stringValue == "weibo" {
                        datas[1].bind = true
                    }
                }
                tableViewRelaod(true)
            }
        }
    }
}


// MARK: - TbaleView -
extension PersonalSafeInfoSettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if datas[indexPath.row].bind { return }
        if indexPath.row == 1 {
            UMSocialDataService.defaultDataService().requestUnOauthWithType(UMShareToSina, completion: nil)
        }
        
        let plam = indexPath.row == 0 ? UMShareToQQ : UMShareToSina
        let identify = indexPath.row == 0 ? "qq" : "weibo"
        let snsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(plam)
        snsPlatform.loginClickHandler(self, UMSocialControllerService.defaultControllerService(), true, { (response) in
            if (response.responseCode == UMSResponseCodeSuccess) {
                let snsAccount = UMSocialAccountManager.socialAccountDictionary()[plam] as! UMSocialAccountEntity
                self.postWithLogin("http://dundun.mog.name/userInfo/oauth", params: ["plam": identify, "auth": snsAccount.usid], identifier: identify)
            }
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView().withBack(MColor.backgroundColor)
        return hv
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("safe") as! PersonalIndexTableViewCell
        cell.initView(datas[indexPath.row].img, title: datas[indexPath.row].lab, line: indexPath.row < 1)
        if datas[indexPath.row].bind {
            cell.setInfo("已绑定")
        }
        return cell
    }
}

// MARK: - 男女选择代理
extension PersonalSafeInfoSettingViewController: PersonalInfoCellSelectProtocol {
    func selectedItem(selected: Int) {
        sex = selected
    }
}
// MARK: - textfield代理事件
extension PersonalSafeInfoSettingViewController: PersonalInfoCellTextFieldProtocol {
    func textChange(text: String?) {
        nick = text
    }
}