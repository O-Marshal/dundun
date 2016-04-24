//
//  PersonalAddressEditViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/24.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class PersonalAddressEditViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    
    let menus = [
        (lab: "姓名", plach: "收货人姓名", identify: "name"),
        (lab: "电话", plach: "收货人联系方式", identify: "pho"),
        (lab: "收货地址", plach: "精确到门牌号", identify: "adr")
    ]
    
    var name: String?
    var pho: String?
    var adr: String?
    
    var model: PersoanlAddressModel?
    
    var delegate: ViewControllerCallBackSuccessProtocol?
    
    
    
    override func initView() {
        title = "编辑收货地址"
        
        tableView.separatorStyle = .None
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    override func initEvent() {
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(PersonalAdrCellNew.classForCoder(), forCellReuseIdentifier: "default")
        tableView.registerClass(PersonalAdrCellBtn.classForCoder(), forCellReuseIdentifier: "btn")
        
        let touch = UITapGestureRecognizer(target: self, action: #selector(touchEvent))
        touch.numberOfTapsRequired = 1
        touch.cancelsTouchesInView = false
        tableView.addGestureRecognizer(touch)
    }
    
    override func netSuccess(result: String, identifier: String?) {
        Notify.show(Murmur: "地址更新成功", theme: NotiTheme.Success)
        delegate?.onSuccess(nil)
        dismissEvent()
    }
    
    
}

extension PersonalAddressEditViewController {
    
    func touchEvent() {
        var cellArr = tableView.visibleCells
        cellArr.removeLast()
        for cell in cellArr {
            (cell as! PersonalAdrCellNew).textField.resignFirstResponder()
        }
    }
    
    func upload() {
        if name == nil {
            return Notify.show(Whisper: "名字不能为空", theme: NotiTheme.Warring, viewController: self)
        }
        if pho == nil {
            return Notify.show(Whisper: "手机号码", theme: NotiTheme.Warring, viewController: self)
        }
        if adr == nil {
            return Notify.show(Whisper: "收货地址不能为空", theme: NotiTheme.Warring, viewController: self)
        }
        postWithLogin("http://dundun.mog.name/adr/update", params: ["aid": model?.id ?? 1 , "name": name!, "pho": pho!, "adr": adr!])
        
    }
}


// MARK: - TbaleView -
extension PersonalAddressEditViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 1 : 3
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
        return indexPath.row == 2 ? 100 : 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if (indexPath.section == 1) {
            let cell = tableView.dequeueReusableCellWithIdentifier("btn") as! PersonalAdrCellBtn
            cell.initView(upload)
            return cell
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("default") as! PersonalAdrCellNew
        cell.initView(menus[indexPath.row].lab, plach: menus[indexPath.row].plach, identify: menus[indexPath.row].identify)
        cell.delegate = self
        if indexPath.row == 2 {
            cell.isTV = true
        }
        if model != nil {
            if indexPath.row == 0 {
                cell.textField.text = model?.name
                name = model?.name
            } else if indexPath.row == 1 {
                cell.textField.text = model?.pho
                pho = model?.pho
            } else {
                cell.textView.text = model?.adr
                adr = model?.adr
            }
        }
        return cell
    }
}

extension PersonalAddressEditViewController: PersonalAdrCellNewProtocol {
    func textChange(text: String?, identify: String?) {
        if identify == menus[0].identify {
            name = text
        } else if identify == menus[1].identify {
            pho = text
        } else if identify == menus[2].identify {
            adr = text
        }
    }
}
