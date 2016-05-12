//
//  PersonalSigViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class PersonalSigViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    typealias MCommonTableViewCellType = (cell: UITableViewCell, height: CGFloat)
    var menus: [MCommonTableViewCellType] = [
        (MHeaderTableViewCell(), 100),
        (MDefaultTableViewCell(), 60)
    ]
    
    var total = "0.00"
    var cash = "0.00"
    var sign = false
    
    // 签到按钮
    let sigButton = UIButton()
    
    override func initView() {
        title = "签到"
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
        tableView.separatorStyle = .None
        sigButton.withAction(self, selector: #selector(sig))
        sigButton.addTo(view).snp_makeConstraints { (make) in
            make.left.bottom.width.equalTo(view)
            make.height.equalTo(50)
        }
        sigButton.setTitle("签         到", forState: .Normal)
        sigButton.backgroundColor = MColor.themeColor
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(MtableViewCommonCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        postWithLogin("http://dundun.mog.name/active/sign", params: ["page": 1])
//        /active/signactive
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let json = MJson.json(result).dictionary {
            total = json["day"]!.stringValue
            cash = json["money"]!.stringValue
            sign = json["type"]!.intValue == 1
        }
        if sign {
            sigButton.setTitle("已   签   到", forState: .Normal)
            sigButton.backgroundColor = MColor.lineDefaultColor
            sigButton.enabled = false
        }
        tableView.reloadData()
    }
    
    func sig() {
        postWithLogin("http://dundun.mog.name/active/signactive", params: ["page": 1])
        sigButton.setTitle("已   签   到", forState: .Normal)
        sigButton.backgroundColor = MColor.lineDefaultColor
        sigButton.enabled = false
    }
}
extension PersonalSigViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            showViewController(PersonalSigListViewController(), sender: nil)
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
            hcell.setLab("签到天数", lab2: "签到奖励")
            hcell.setData(total, num2: cash)
        case 1:
            let dcell = cell as! MDefaultTableViewCell
            dcell.setLab("签到记录")
            dcell.setNext()
        default:
            break
        }
        return cell
    }
}
