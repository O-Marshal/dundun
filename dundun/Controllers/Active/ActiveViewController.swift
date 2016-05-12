//
//  ActiveViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit
import SwiftyJSON

class ActiveViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    
    var datas: [ActiveModel] = []
    
    override func initView() {
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
        tableView.rowHeight = 180
        tableView.separatorStyle = .None
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(ActivetableViewCell.classForCoder(), forCellReuseIdentifier: "active")
        get("http://dundun.mog.name/active/list")
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let jsonArr = MJson.json(result).array {
            for item in jsonArr {
                datas.append(ActiveModel(jsonString: item.description))
            }
            tableViewRelaod()
        }
    }
}

extension ActiveViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let webView = WebViewController()
        webView.title = datas[indexPath.row].title
        webView.url = datas[indexPath.row].url!
        showViewController(webView, sender: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("active") as! ActivetableViewCell
        cell.initView(datas[indexPath.row])
        return cell
    }
}
