//
//  WalletCardInfoViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SwiftyJSON

class WalletCardInfoViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    
    var cardInfo = ""
    
    var cid = 0
    var shop = "盾盾官方商城"
    var isBind = true
    
    class func show(vc: UIViewController, cardInfo: String) {
        let v = WalletCardInfoViewController()
        v.cardInfo = cardInfo
        vc.showViewController(v, sender: nil)
    }
    override func initView() {
        title = "卡卷信息"
        
        tableView.separatorStyle = .None
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    override func initEvent() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(WalletCardInfoTableViewCell.classForCoder(), forCellReuseIdentifier: "default")
        tableView.registerClass(PersonalAdrCellBtn.classForCoder(), forCellReuseIdentifier: "btn")
        
        get("http://dundun.mog.name/card/info/\(cardInfo)")
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if identifier == "bind" {
            Notify.show(Whisper: "卡卷绑定成功", theme: NotiTheme.Success, viewController: self)
            isBind = true
            return tableView.reloadData()
        }
        if let jsonDict = MJson.json(result).dictionary {
            cid = jsonDict["cid"]!.intValue
            shop = jsonDict["shop"]!.stringValue
            isBind = jsonDict["status"]?.intValue == 1
            tableView.reloadData()
        }
    }
}

extension WalletCardInfoViewController {
    
    func listEvent() {
        showViewController(WalletCashListViewController(), sender: nil)
    }
    
    func upload() {
        postWithLogin("http://dundun.mog.name/card/bind", params: ["cid": cid], identifier: "bind")
    }
}


// MARK: - TbaleView -
extension WalletCardInfoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 1 : 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return isBind ? 1 : 2
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView().withBack(MColor.backgroundColor)
        return hv
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 20 : 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("btn") as! PersonalAdrCellBtn
            cell.initView(upload)
            cell.setTitle("绑   定")
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("default") as! WalletCardInfoTableViewCell
        if indexPath.row == 0 {
            cell.initView("卡卷编号", info: "ID-\(cid)")
        } else if indexPath.row == 1 {
            cell.initView("商家信息", info: shop)
        } else if indexPath.row == 2 {
            cell.initView("卡卷状态", info: isBind ? "已绑定" : "可绑定")
            if !isBind {
                cell.setInfoColor(UIColor.greenColor())
            } else {
                cell.setInfoColor(MColor.infoErrorColor)
            }
        }
        cell.isLast = indexPath.row == (isBind ? 2 : 3)
        return cell
    }
}