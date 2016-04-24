//
//  InvitationViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class InvitationViewController: BillBaseViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "邀请记录"
        tableView?.registerClass(BillWithDetailTableViewCell.classForCoder(), forCellReuseIdentifier:  NSStringFromClass(BillWithDetailTableViewCell))
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(BillWithDetailTableViewCell)) as! BillTableViewCell
        cell.titleLable?.text = "邀请奖励"
        cell.timeLable?.text = "今天6:00"
        cell.moneyLable?.text = "+80.0"
        cell.detail?.text = "邀请习大大加入"
        cell.billImageView?.image = UIImage(named: "qiandaojiangli")
        
        return cell
    }
    
}
