//
//  BillBaseViewController.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/13.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class BillBaseViewController: BaseViewController , UITableViewDataSource, UITableViewDelegate{

    var tableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        //initBaseNavBar()
        initCommonNavBackItem()
        navigationItem.title = "我的账单"
        tableView = UITableView(frame: view.frame, style: UITableViewStyle.Plain)
        view.addSubview(tableView!)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}
