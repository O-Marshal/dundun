//
//  PersonalSettingViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Kingfisher

class PersonalSettingViewController: BaseViewController, CommonTableViewAnimationProtocol {
    
    let tableView = UITableView()
    
    var isLogin = false
    
    let menus = [
        (img: "user_clean", title: "清除缓存"),
        (img: "user_feedback", title: "意见反馈"),
        (img: "user_kefu", title: "联系客服"),
        (img: "user_wallet", title: "关于盾盾")
    ]
    
    override func initView() {
        title = "系统设置"
        tableView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    override func initEvent() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .None
        tableView.sectionHeaderHeight = 10
        tableView.registerClass(PersonalIndexTableViewCell.classForCoder(), forCellReuseIdentifier: "default")
        async_main_after(1) {
            self.tableViewRelaod(true)
        }
    }

}

var rongLogin = false

// MARK: - TbaleView -
extension PersonalSettingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            let cache = KingfisherManager.sharedManager.cache
            cache.clearMemoryCache()
            cache.clearDiskCache()
            cache.cleanExpiredDiskCache()
            cache.cleanExpiredDiskCacheWithCompletionHander({ 
                cache.clearDiskCacheWithCompletionHandler({ 
                    Notify.show(Murmur: "缓存清空成功", theme: NotiTheme.Success)
                    tableView.reloadData()
                })
            })
        } else if indexPath.row == 1 {
            showViewController(FeedBackViewController(), sender: nil)
        } else if indexPath.row == 2 {
            if rongLogin {
                let chat = MConversationViewController()
                chat.conversationType = RCConversationType.ConversationType_PRIVATE
                chat.targetId = "dundun-kefu"
                chat.title = "盾盾客服"
                showViewController(chat, sender: nil)
            }
            
            if !isLogin {
                isLogin = true
                RCIM.sharedRCIM().connectWithToken("Zn79Hku+Psmu/8M9iRcoCvLvHUdchZ3xQqfLL8MieifpeJP/k5dCMzKDowcpSXVc7w9P6GKccH1AXqyxPakQvdRokOLwRV+R", success: { (userID) in
                    rongLogin = true
                    self.async_main({ 
                        let chat = MConversationViewController()
                        chat.conversationType = RCConversationType.ConversationType_PRIVATE
                        chat.targetId = "dundun-kefu"
                        chat.title = "盾盾客服"
                        self.showViewController(chat, sender: nil)
                    })
                    }, error: { (status) -> Void in
                        Notify.show(Murmur: "融云服务器登录失败,请稍后再试", theme: NotiTheme.Error)
                    }, tokenIncorrect: {
                        Notify.show(Murmur: "融云服务器登录失败,请稍后再试", theme: NotiTheme.Error)
                })
            }
        } else if indexPath.row == 3 {
            showViewController(PersonalAboutViewController(), sender: nil)
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hv = UIView().withBack(MColor.backgroundColor)
        hv.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 10)
        return hv
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("default") as! PersonalIndexTableViewCell
        cell.initView(menus[indexPath.row].img, title: menus[indexPath.row].title, line: indexPath.row != 3)
        if indexPath.row == 0 {
            let cache = KingfisherManager.sharedManager.cache
            // 获取硬盘缓存的大小
            cache.calculateDiskCacheSizeWithCompletionHandler { (size) -> () in
                cell.setInfo("\(String(format: "%.2f", Float(size / 1000) / 1000)) MB")
            }
        }
        return cell
    }
    
    
}
