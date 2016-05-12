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
    var modelArray:[GoodsModel] = []
  
    override func initView() {
        title = "我的订单"
        startDownload()
        creatTableView()
    }
    func startDownload() {
        postWithLogin("http://dundun.mog.name/order/list", params: [:])
    }
    override func netSuccess(result: String, identifier: String?) {
        print(result)
        if let jsonArr = MJson.json(result).array {
            var objtArr: [MyIndentModel] = []
            var modelArr: [GoodsModel] = []
            for dic in jsonArr {
//                print(dic)
//                let dic = dict as! [String : JSON]
                let myindent = MyIndentModel()
                let model = GoodsModel()
                myindent.money = dic["money"].stringValue
                myindent.orderid = dic["orderid"].stringValue
                myindent.time = dic["time"].stringValue
                myindent.status = dic["status"].intValue
                objtArr.append(myindent)
                let dict = dic["goods"].dictionaryValue
                model.thumb = (dict["thumb"]?.stringValue)!
                model.price = (dict["price"]?.floatValue)!
                model.name = (dict["name"]?.stringValue)!
                model.brief = (dict["brief"]?.stringValue)!
                
                modelArr.append(model)
            }
            dataArray = objtArr
            modelArray = modelArr
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mol = dataArray[indexPath.row]
        let good = modelArray[indexPath.row]
        amount = mol.money!
        numberss = mol.orderid!
        times = mol.time!
        count = Int(mol.money!)! / Int(good.price)
        if mol.status == -1 {
//            btnString = "订单取消"
//            labelString = "查看订单"
            let indent = IndentViewController()
            indent.model = good
          
            showViewController(indent, sender: nil)
            
        }
        if mol.status == 0 {
//            btnString = "付款"
//            labelString = "待付款"
            let pay = PayViewController()
            pay.model = good
          
            showViewController(pay, sender: nil)
        }
        if mol.status == 1 {
//            btnString = "查看订单"
//            labelString = "待发货"
            let  seller =
            SellerViewController()
            seller.model = good
            
            showViewController(seller, sender: nil)
        }
        if mol.status == 2 {
//            btnString = "查看物流"
//            labelString = "待收货"
            let logistic = ReciveViewController()
            logistic.model = good
            showViewController(logistic, sender: nil)
            
        }
        if mol.status == 3 {
//            btnString = "再来一单"
//            labelString = "交易成功"
            let pay = PayViewController()
            pay.model = good
          
            showViewController(pay, sender: nil)
        }
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = ShoppingListCell()
        cell.setData(modelArray[indexPath.row])
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
        return cell
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return  280
    }
}
