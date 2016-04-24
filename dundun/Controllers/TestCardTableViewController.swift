//
//  TestTableViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class TestCardTableViewController: UITableViewController {

    let list = ["卡券详情-可绑定", "卡券详情-未生效", "卡券详情-已绑定", "卡券详情-已过期", "卡券详情-已生效"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        let name = list[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0
        { navigationController?.pushViewController(CardCanBindingViewController(), animated: false) }
        if indexPath.row == 1
        { navigationController?.pushViewController(CardIneffectiveViewController(), animated: false) }
        if indexPath.row == 2
        { navigationController?.pushViewController(CardDidBindingViewController(), animated: false) }
        if indexPath.row == 3
        { navigationController?.pushViewController(CardCanBindingViewController(), animated: false) }
        if indexPath.row == 4
        { navigationController?.pushViewController(CardCanBindingViewController(), animated: false) }
    }

}
