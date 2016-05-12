//
//  WalletCashViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/9.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletCashViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    
    let menus = [
        (lab: "姓名", plach: "真实姓名", identify: "name"),
        (lab: "卡号", plach: "银行卡号或支付宝账号", identify: "num"),
        (lab: "账户类型", plach: "支付宝、工商、建行", identify: "type"),
        (lab: "金额", plach: "需要大于100的整数", identify: "money")
    ]
    
    var name = ""
    var num = "0"
    var type = ""
    var money = "0"
    
    var delegate: ViewControllerCallBackSuccessProtocol?
    
    
    
    override func initView() {
        title = "提现申请"
        
        tableView.separatorStyle = .None
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    override func initEvent() {
        
        tableView.dataSource = self
        tableView.delegate = self
        initNavRigtBarButton()
        
        tableView.registerClass(PersonalAdrCellNew.classForCoder(), forCellReuseIdentifier: "default")
        tableView.registerClass(PersonalAdrCellBtn.classForCoder(), forCellReuseIdentifier: "btn")
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(touchEvent))
        touch.numberOfTapsRequired = 1
        touch.cancelsTouchesInView = false
        tableView.addGestureRecognizer(touch)
    }
    
    override func netSuccess(result: String, identifier: String?) {
        Notify.show(Murmur: "提现申请成功，客服将在3个工作日内完成提现", theme: NotiTheme.Success)
        name = ""
        num = "0"
        type = ""
        money = "0"
        tableView.reloadData()
    }
    
    
}

extension WalletCashViewController {
    
    func initNavRigtBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提现记录", style: .Plain, target: self, action: #selector(listEvent))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(14)], forState: .Normal)
    }
    
    func listEvent() {
        showViewController(WalletCashListViewController(), sender: nil)
    }
    
    func touchEvent() {
        var cellArr = tableView.visibleCells
        cellArr.removeLast()
        for cell in cellArr {
            (cell as! PersonalAdrCellNew).textField.resignFirstResponder()
        }
    }
    
    func upload() {
        if name.characters.count == 0 {
            return Notify.show(Whisper: "名字不能为空", theme: NotiTheme.Warring, viewController: self)
        }
        if num.characters.count == 0 {
            return Notify.show(Whisper: "卡号不能为空", theme: NotiTheme.Warring, viewController: self)
        }
        if type.characters.count == 0 {
            return Notify.show(Whisper: "请注明收款账户类型", theme: NotiTheme.Warring, viewController: self)
        }
        if Int(money) < 100 {
            return Notify.show(Whisper: "提现金额必须大于等于一百", theme: NotiTheme.Warring, viewController: self)
        }
        
        postWithLogin("http://dundun.mog.name/money/cash", params: ["name": name, "num": num, "type": type, "money": money])
    }
}


// MARK: - TbaleView -
extension WalletCashViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 1 : 4
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
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
            cell.setTitle("提    交")
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("default") as! PersonalAdrCellNew
        cell.initView(menus[indexPath.row].lab, plach: menus[indexPath.row].plach, identify: menus[indexPath.row].identify)
        cell.delegate = self
        return cell
    }
}

extension WalletCashViewController: PersonalAdrCellNewProtocol {
    func textChange(text: String?, identify: String?) {
        if identify == menus[0].identify {
            name = text!
        } else if identify == menus[1].identify {
            num = text!
        } else if identify == menus[2].identify {
            type = text!
        } else {
            money = text!
        }
    }
}