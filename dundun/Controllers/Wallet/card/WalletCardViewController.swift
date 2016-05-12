//
//  WalletCardViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SwiftyJSON

class WalletCardViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    typealias MCommonTableViewCellType = (cell: UITableViewCell, height: CGFloat)
    var menus: [MCommonTableViewCellType] = [
        (MHeaderTableViewCell(), 100),
        (MRankTableViewCell(), 150),
        (MDefaultTableViewCell(), 60),
        (MDefaultTableViewCell(), 60)
    ]
    
    var total = "0.00"
    var cash = "0.00"
    var rank = "0"
    
    override func initView() {
        title = "账户明细"
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
        tableView.separatorStyle = .None
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(MtableViewCommonCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        postWithLogin("http://dundun.mog.name/wallet/card", params: ["page": 1])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let json = MJson.json(result).dictionary {
            total = json["total"]!.stringValue
            cash = json["cash"]!.stringValue
            rank = json["rank"]!.stringValue
        }
        tableView.reloadData()
    }
}
extension WalletCardViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            showViewController(WalletCardBindListTableView(), sender: nil)
        } else if indexPath.section == 3 {
            showViewController(WalletCardCashListTableView(), sender: nil)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView().withBack(MColor.backgroundColor)
        hv.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 10)
        return hv
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return menus[indexPath.section].height
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = menus[indexPath.section].cell
        switch indexPath.section {
        case 0:
            let hcell = cell as! MHeaderTableViewCell
            hcell.setLab("卡卷总数", lab2: "已经返现")
            hcell.setData(total, num2: cash)
        case 1:
            let rcell = cell as! MRankTableViewCell
            rcell.setData(rank)
        case 2:
            let dcell = cell as! MDefaultTableViewCell
            dcell.setLab("卡卷绑定记录")
            dcell.setNext()
        case 3:
            let dcell = cell as! MDefaultTableViewCell
            dcell.setLab("卡卷返现列表")
            dcell.setNext()
        default:
            break
        }
        return cell
    }
}
