//
//  PersonalSettingViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Kingfisher

class PersonalSettingViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    
    let menus = [
        (img: "user_clean", title: "清除缓存"),
        (img: "user_feedback", title: "意见反馈"),
        (img: "user_kefu", title: "联系客服"),
        (img: "user_wallet", title: "关于盾盾")
    ]
    
    override func initView() {
        title = "系统设置"
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.sectionHeaderHeight = 10
        tableView.registerClass(PersonalIndexTableViewCell.classForCoder(), forCellReuseIdentifier: "default")
        async_main_after(1) {
            self.tableViewRelaod(true)
        }
    }

}

// MARK: - TbaleView -
extension PersonalSettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        KingfisherManager.sharedManager.cache
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView().withBack(MColor.backgroundColor)
        hv.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 10)
        return hv
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("default") as! PersonalIndexTableViewCell
        cell.initView(menus[indexPath.row].img, title: menus[indexPath.row].title, line: indexPath.row != 3)
        if indexPath.row == 0 {
            cell.setInfo("13.24M")
        }
        return cell
    }
    
    
}
