//
//  WalletAccountTableView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SwiftyJSON

class WalletAccountTableView: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    var datas: [MtableViewCommonModel] = []
    
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
        tableView.registerClass(NoneTableViewCell.classForCoder(), forCellReuseIdentifier: "none")
        postWithLogin("http://dundun.mog.name/wallet/list", params: ["page": 1])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let jsonArray = MJson.json(result).array {
            datas += jsonArray.map({ MtableViewCommonModel(jsonString: $0.description) })
            tableView.reloadData()
        }
    }

}

extension WalletAccountTableView: UITableViewDataSource, UITableViewDelegate {
    
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
        return cell
    }
}