//
//  MyIndentController.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/11.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SwiftyJSON

class MyIndentController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
 
    let tableView = UITableView()
    var dataArray:[MyIndentModel] = []
    
    override func initView() {
        title = "我的订单"
        startDownload()
        creatTableView()
    }
    func startDownload() {
        postWithLogin("http://dundun.mog.name/order/list", params: [:])
    }
    override func netSuccess(result: String, identifier: String?) {
        if let jsonArr = MJson.json(result).array {
            var objtArr: [MyIndentModel] = []
            for dic in jsonArr {
                print(dic)
//                let dic = dict as! [String : JSON]
                let myindent = MyIndentModel()
                myindent.money = dic["money"].stringValue
                myindent.good = dic["good"].stringValue
                myindent.status = dic["status"].intValue
                objtArr.append(myindent)
            }
            dataArray = objtArr
            print(dataArray.count)
            tableView.reloadData()
        }
    }
    func creatTableView()  {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = bgColor
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.equalTo(view).offset(5)
            make.right.equalTo(view).offset(-5)
            make.height.equalTo(view)
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataArray.count)
        return dataArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ShoppingListCell()
        cell.model = dataArray[indexPath.row]
        
        cell.selectionStyle = .None
        let storeName = cell.createStoreName()
        let detail = cell.createDetail(storeName, bgforeColor: UIColor.whiteColor())
        let totalPrice = cell.totalPrice(detail,totalCount: amount) as! UILabel
        cell.addSepLine(storeName)
        cell.addSepLine(detail)
        cell.applyRefund()
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 10))
        view.backgroundColor = bgColor
        cell.contentView.addSubview(view)
//        cell.backgroundColor = UIColor.whiteColor()
        return cell
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return  280
    }
}
