//
//  PersonalAddressViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/24.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
protocol PersonalAddressViewControllerProtocol {
    func onSelected(model: PersoanlAddressModel)
}

class PersonalAddressViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    
    var datas: [PersoanlAddressModel] = []
    
    var delegate: PersonalAddressViewControllerProtocol?
    
    override func initView() {
        title = "收货地址"
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
        initRightBackBarButton()
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        
        tableView.registerClass(PersonalAdrCellDefault.classForCoder(), forCellReuseIdentifier: "default")
        tableView.sectionHeaderHeight = 15
        
        postWithLogin("http://dundun.mog.name/adr/list", params: [:])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let dict = MJson.json(result).array {
            datas += dict.map({ PersoanlAddressModel(jsonString: $0.description) })
            tableViewRelaod()
        }
    }

}

extension PersonalAddressViewController {
    func initRightBackBarButton() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新增", style: .Plain, target: self, action: #selector(newAddress))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(autoSize(12, max: 14))], forState: .Normal)
    }
    func newAddress() {
        let padr = PersonalAddressNewViewController()
        padr.delegate = self
        showViewController(padr, sender: nil)
    }
}



// MARK: - TbaleView -
extension PersonalAddressViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let sel = delegate {
            sel.onSelected(datas[indexPath.section])
            dismissEvent()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView().withBack(MColor.backgroundColor)
        hv.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 10)
        return hv
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("default") as! PersonalAdrCellDefault
        cell.initView { (index) in
            let padr = PersonalAddressEditViewController()
            padr.delegate = self
            padr.model = self.datas[indexPath.section]
            self.showViewController(padr, sender: nil)
        }
        cell.setData(datas[indexPath.section], index: indexPath.section)
        return cell
    }
}

// MARK: - 地址变更回调事件
extension PersonalAddressViewController: ViewControllerCallBackSuccessProtocol {
    func onSuccess(identify: String?) {
        postWithLogin("http://dundun.mog.name/adr/list", params: [:])
    }
}