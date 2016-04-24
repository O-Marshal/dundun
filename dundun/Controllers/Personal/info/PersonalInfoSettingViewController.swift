//
//  PersonalInfoSettingViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import ALCameraViewController

protocol PersonalInfoSettingViewControllerProtocol {
    func onSuccess()
}


class PersonalInfoSettingViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    
    var img: UIImage?
    var nick: String?
    var sex = 0
    
    
    var delegate: PersonalInfoSettingViewControllerProtocol?
    
    let textFieldcell = PersonalInfoCellTextField()
    let imageCell = PersonalInfoCellHeader()
    
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
        let touch = UITapGestureRecognizer(target: self, action: #selector(touchEvent))
        touch.numberOfTapsRequired = 1
        touch.cancelsTouchesInView = false
        tableView.addGestureRecognizer(touch)
        async_main_after(1) {
            self.tableViewRelaod(true)
        }
    }
    
    override func netSuccess(result: String, identifier: String?) {
        Notify.show(Murmur: "资料更新成功", theme: NotiTheme.Success)
        delegate?.onSuccess()
        dismissEvent()
    }
    

}

extension PersonalInfoSettingViewController {
    
    func upload() {
        navigationItem.rightBarButtonItem?.enabled = false
        navigationItem.rightBarButtonItem?.title = "提交中..."
        
        var dict: [String: AnyObject] = [:]
        if img != nil {
            dict["headerImage"] = UIImagePNGRepresentation(img!.scaleToSize(CGSize(width: 100, height: 100)))
        }
        if nick != nil {
            dict["nick"] = nick
        }
        dict["sex"] = sex
        
        postImageWithLogin("http://dundun.mog.name/userInfo/upload", params: dict)
    }
    
    func initRightBackBarButton() {
        navigationItem.hidesBackButton = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "提交", style: .Plain, target: self, action: #selector(upload))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(autoSize(12, max: 14))], forState: .Normal)
    }
    
    func setImage(img: UIImage?) {
        self.img = img
    }
    
    func touchEvent() {
        textFieldcell.textField.resignFirstResponder()
    }
    
}


// MARK: - TbaleView -
extension PersonalInfoSettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 0 {
            let cameraViewController = CameraViewController(croppingEnabled: true, allowsLibraryAccess: true, completion: { (image, _) in
                self.setImage(image)
                self.dismissViewControllerAnimated(true, completion: nil)
            })
            presentViewController(cameraViewController, animated: true, completion: nil)
        }
        
        if indexPath.section == 1 && indexPath.row == 0 {
            showViewController(PersonalAddressViewController(), sender: nil)
        }
    }
    
    
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
            textFieldcell.initView()
            textFieldcell.setData(nick, delegate: self)
            return textFieldcell
        case 2:
            let cell = PersonalInfoCellSelect()
            cell.initView()
            cell.setData( sex, delegate: self)
            return cell
        default:
            if indexPath.section == 1 {
                let cell = PersonalInfoCellAddress()
                cell.initView()
                return cell
            }
            imageCell.initView()
            imageCell.setData(img)
            return imageCell
        }
    }
}

// MARK: - 男女选择代理
extension PersonalInfoSettingViewController: PersonalInfoCellSelectProtocol {
    func selectedItem(selected: Int) {
        sex = selected
    }
}
// MARK: - textfield代理事件
extension PersonalInfoSettingViewController: PersonalInfoCellTextFieldProtocol {
    func textChange(text: String?) {
        nick = text
    }
}