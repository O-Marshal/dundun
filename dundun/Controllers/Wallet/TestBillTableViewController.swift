//
//  TestBillTableViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class TestBillTableViewController: UITableViewController {

    let list = ["卡券绑定记录-列表", "卡券生效记录-列表", "我的账单-列表", "消息通知", "邀请记录"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return list.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let name = list[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0
        { navigationController?.pushViewController(BindinggRecordViewController(), animated: false) }
        if indexPath.row == 1
        { navigationController?.pushViewController(EffectiveRecordViewController(), animated: false) }
        
        if indexPath.row == 2
        { navigationController?.pushViewController(InvitationViewController(), animated: false) }
        if indexPath.row == 3
        { navigationController?.pushViewController(MasageCenterViewController(), animated: false) }
        if indexPath.row == 4
        { navigationController?.pushViewController(InvitationViewController(), animated: false) }
        
    }
}
