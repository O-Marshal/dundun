//
//  LogisticInfoController.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/11.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class LogisticInfoController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
 
    override func initView() {
        title = "物流信息"
        createTableView()
    }
    func createTableView() {
        let tableView = UITableView(frame: view.frame)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = bgColor
        tableView.separatorStyle = .None
        view.addSubview(tableView)
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        
        if indexPath.row <= 1 {
         let cell = UITableViewCell()
            cell.backgroundColor = UIColor.whiteColor()
        // 添加cell之间间距
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 15))
        view.backgroundColor = bgColor
        cell.contentView.addSubview(view)
        
        let label1 = UILabel()
        cell.contentView.addSubview(label1)
        label1.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(cell.contentView).offset(15 + 15)
            make.left.equalTo(cell.contentView).offset(15)
        })
        if indexPath.row == 0 {
            label1.text = "快递"
            
            let label2 = UILabel()
            label2.text = "圆通快递"
            label2.textColor = UIColor.grayColor()
            cell.contentView.addSubview(label2)
            label2.snp_makeConstraints(closure: { (make) in
                make.top.equalTo(cell.contentView).offset(15 + 15)
                make.left.equalTo(label1.snp_right).offset(30)
            })
           return cell
        }
        if indexPath.row == 1 {
            label1.text = "物流信息"
            return cell
        }
        }
        let cell = LogisticInfoCell()
        cell.backgroundColor = UIColor.whiteColor()
        // 添加分割线
        
        let view = UIView(frame: CGRect(x: 15, y: 0, width: self.view.frame.size.width, height: 1))
        view.transform = CGAffineTransformMakeScale(1, 0.5)
        view.backgroundColor = UIColor.grayColor()
        cell.contentView.addSubview(view)
        return cell
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row <= 1 {
            return 70
        }
        return 55
    }
}
