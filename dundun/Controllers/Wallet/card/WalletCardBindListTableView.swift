//
//  WalletCardBindListTableView.swift
//  dundun
//
//  Created by 刘荣 on 16/5/1.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletCardBindListTableView: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    var datas: [MtableViewCommonModel] = []
    
    override func initView() {
        title = "卡卷绑定记录"
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
        tableView.separatorStyle = .None
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(MtableViewCommonCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.registerClass(NoneTableViewCell.classForCoder(), forCellReuseIdentifier: "none")
        postWithLogin("http://dundun.mog.name/wallet/cardbindlist", params: ["page": 1])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let jsonArray = MJson.json(result).array {
            datas += jsonArray.map({ MtableViewCommonModel(type: "m1", title: "绑定卡卷", desc: $0["desc"].stringValue, money: $0["money"].floatValue.cfloatValue, time: $0["time"].stringValue) })
            tableView.reloadData()
        }
    }
    
}

extension WalletCardBindListTableView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count == 0 ? 1 : datas.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return datas.count == 0 ? MSize.defaultSize.height : 80
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if datas.count == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("none") as! NoneTableViewCell
            cell.labView.text = "没有记录"
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! MtableViewCommonCell
        cell.setAccount(datas[indexPath.row])
        cell.isNext = true
        cell.notNum = true
        return cell
    }
}