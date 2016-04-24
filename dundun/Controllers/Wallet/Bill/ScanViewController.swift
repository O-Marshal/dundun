//
//  ScanViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/14.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class ScanViewController: BillBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "返现记录"
        tableView?.registerClass(BillTableViewCell.classForCoder(), forCellReuseIdentifier:  NSStringFromClass(BillTableViewCell))
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(BillTableViewCell)) as! BillTableViewCell
        cell.titleLable?.text = "系统分红"
        cell.timeLable?.text = "今天6:00"
        cell.moneyLable?.text = "+28"
        cell.billImageView?.image = UIImage(named: "system.scan")
        return cell
    }
    


}
