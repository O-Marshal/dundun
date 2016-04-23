//
//  PersonalInfoSettingViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit


class PersonalInfoSettingViewController: BaseViewController {
    
    let tableView = UITableView()
    
    override func initView() {
        title = "个人资料"
        
        tableView.separatorStyle = .None
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    override func initEvent() {
        initRightBackBarButton()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    

}

// MARK: - 导航栏右键 -
extension PersonalInfoSettingViewController {
    
    func upload() {
        
    }
    
    func initRightBackBarButton() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: .Plain, target: self, action: #selector(upload))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(autoSize(12, max: 14))], forState: .Normal)
    }
    
}


// MARK: - TbaleView -
extension PersonalInfoSettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    
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
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return indexPath.section == 1 ? 60 : 80
        default:
            return 60
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let cell = PersonalInfoCellTextField()
            cell.initView()
            return cell
        case 2:
            let cell = PersonalInfoCellSelect()
            cell.initView()
            cell.setData(0, delegate: self)
            return cell
        default:
            if indexPath.section == 1 {
                let cell = PersonalInfoCellAddress()
                cell.initView()
                return cell
            }
            let cell = PersonalInfoCellHeader()
            cell.initView()
            return cell
        }
    }
    
}

extension PersonalInfoSettingViewController: PersonalInfoCellSelectProtocol {
    
    func selectedItem(selected: Int) {
        print(selected)
    }
    
}