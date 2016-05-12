//
//  PersonalInvateViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class PersonalInvateViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    typealias MCommonTableViewCellType = (cell: UITableViewCell, height: CGFloat)
    var menus: [MCommonTableViewCellType] = [
        (MHeaderTableViewCell(), 100),
        (MDefaultTableViewCell(), 60),
        (MDefaultTableViewCell(), 60)
    ]
    
    var total = "0.00"
    var cash = "0.00"
    var code = "0"
    
    override func initView() {
        title = "我的邀请"
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
        tableView.separatorStyle = .None
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(MtableViewCommonCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        postWithLogin("http://dundun.mog.name/active/invite", params: ["page": 1])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let json = MJson.json(result).dictionary {
            total = json["peopel"]!.stringValue
            cash = json["money"]!.stringValue
            code = json["code"]!.stringValue
        }
        tableView.reloadData()
    }
}
extension PersonalInvateViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 2 {
            showViewController(PersonalInvateListViewController(), sender: nil)
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
            hcell.setLab("邀请用户", lab2: "获得奖励")
            hcell.setData(total, num2: cash)
        case 1:
            let dcell = cell as! MDefaultTableViewCell
            dcell.setLab("我的邀请码")
            dcell.setData(code)
        case 2:
            let dcell = cell as! MDefaultTableViewCell
            dcell.setLab("邀请记录")
            dcell.setNext()
        default:
            break
        }
        return cell
    }
}
