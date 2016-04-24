//
//  SellerViewController.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class SellerViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate{
    var FooterLabel2: UILabel?
    var label2 : UILabel?
    
     override func initView() {
            title = "订单支付"
            let colors = [blue, blue, blue, gray, themColor, themColor, gray]
            // 创建top的物流流程View 并赋予颜色 tag
            self.createIndentFlow(view, colors: colors, tag: 1003)
            // 创建物流信息View
            self.createIndentInfo(view, numberss: "201006030201", totalss: amount, times: "2016.4.9")
            // 创建tableView
            self.createTableView()
            
            // 创建界面最下面的一个View
            let AffimView = self.createAffimView(view, tag: 2003)
            // 创建申请退款(右边)btn 点击并跳转退款界面
            let rightView = createRightView(AffimView, rightTitle: "申请退款")
            rightView.withAction(self, selector: #selector(SellerViewController.show))
            // 创建左边的代发货View
            creatLeftView(AffimView, leftTitle: "待发货", isCount: false, isBtn: false)
        

    }
    func show () {
        showViewController(ReciveViewController(), sender: nil)
    }
    
    func createTableView(){
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = bgColor
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(100 + 140)
            make.width.equalTo(view)
            make.height.equalTo(280)
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = ShoppingListCell(style: .Value1, reuseIdentifier: "cell")
        let storeName = cell.createStoreName()
        let detail = cell.createDetail(storeName, bgforeColor: bgColor)
        cell.count(detail, isHiddenAddSub: true, totalCount: count!)
        cell.selectionStyle = .None
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       
        return 220
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = white
        
        let leftView = UIView()
        leftView.backgroundColor = UIColor.whiteColor()
        footerView.addSubview(leftView)
        leftView.snp_makeConstraints { (make) in
            make.right.equalTo(footerView)
            make.left.equalTo(footerView.snp_centerX).offset(-50)
            make.bottom.equalTo(footerView)
            make.top.equalTo(footerView)
        }
        let label1 = UILabel()
        label1.text = "合计:"
        label1.textAlignment = .Right
        leftView.addSubview(label1)
        label1.snp_makeConstraints { (make) in
            make.top.equalTo(leftView).offset(15)
            make.left.equalTo(leftView.snp_centerX)
        }
        let label2 = UILabel()
        self.FooterLabel2 = label2
        leftView.addSubview(label2)
        label2.textAlignment = .Left
        label2.textColor = red
        label2.text = amount
        label2.snp_makeConstraints { (make) in
            make.top.equalTo(leftView).offset(15)
            make.left.equalTo(label1.snp_right).offset(5)
        }
        
        return footerView
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }

}
