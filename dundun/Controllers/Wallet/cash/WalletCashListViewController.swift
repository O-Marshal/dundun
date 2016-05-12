//
//  WalletCashListViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletCashListViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    var datas: [MtableViewCommonModel] = []
    
    override func initView() {
        title = "卡卷返现记录"
        tableView.rowHeight = 80
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
        tableView.separatorStyle = .None
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(MtableViewCommonCell.classForCoder(), forCellReuseIdentifier: "cell")
        
        postWithLogin("http://dundun.mog.name/wallet/cardedlist", params: ["page": 1])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let jsonArray = MJson.json(result).array {
            datas += jsonArray.map({ MtableViewCommonModel(type: "cash", title: "卡卷返现", desc: $0["desc"].stringValue, money: $0["money"].floatValue.cfloatValue, time: $0["time"].stringValue) })
            tableView.reloadData()
        }
    }
    
}

extension WalletCashListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! MtableViewCommonCell
        cell.setAccount(datas[indexPath.row])
        cell.notNum = true
        return cell
    }
}