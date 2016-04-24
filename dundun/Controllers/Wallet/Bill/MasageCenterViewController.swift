//
//  MasageCenterViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MasageCenterViewController: BillBaseViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "消息中心"
        tableView?.registerClass(MasageTableViewCell.classForCoder(), forCellReuseIdentifier:  NSStringFromClass(MasageTableViewCell))
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(MasageTableViewCell)) as! BillTableViewCell
        cell.titleLable?.text = "付款成功"
        cell.timeLable?.text = "今天6:00"
        cell.detail?.text = "今天你有卖东西ID奋斗奋斗奋斗奋斗 费大幅度发丰富的地方 地方放大"
        cell.billImageView?.image = UIImage(named: "shangpin")
        return cell
    }

    
}
