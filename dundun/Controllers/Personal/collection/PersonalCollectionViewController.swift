//
//  PersonalCollectionViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SwiftyJSON

class PersonalCollectionViewController: BaseViewController {
    
    let tableView = UITableView()
    let coreLocation = CLLocationManager()
    
    var datas: [colDataType] = []
    
    typealias colDataType = (id: Int, name: String,logo: String, desc: String)
    
    override func initView() {
        title = "我的收藏"
        tableView.separatorStyle = .None
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.size.equalTo(view)
        }
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(LocalTableViewCell.classForCoder(), forCellReuseIdentifier: "local")
        postWithLogin("http://dundun.mog.name/shop/clist", params: ["page": 1])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let jsonArray = MJson.json(result).array {
            datas += jsonArray.map({ ($0["id"].intValue, $0["shopName"].stringValue, $0["logo"].stringValue, $0["locale"].stringValue) })
            tableView.reloadData()
        }
    }
    
}

extension PersonalCollectionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        ShopViewController.show(self, pid: datas[indexPath.row].id)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count == 0 ? 1 : datas.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return datas.count == 0 ? view.frame.height : 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if datas.count == 0 {
            let cell = NoneTableViewCell()
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("local") as! LocalTableViewCell
        cell.setData(datas[indexPath.row].name,logo: datas[indexPath.row].logo, desc: datas[indexPath.row].desc, dest: 0)
        return cell
    }
}