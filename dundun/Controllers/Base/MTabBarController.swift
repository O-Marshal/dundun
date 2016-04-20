//
//  MTabBarController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var tabs: [String] = []
    
    override func viewDidLoad() {
        
        tabBar.tintColor = MColor.themeColor
        
        addBarItems(WalletViewController(), img: "tab_wallet", title: "盾盾钱包")
        addBarItems(GoodsViewController(), img: "tab_shopping", title: "推荐商品")
        addBarItems(ActiveViewController(), img: "tab_active", title: "活动")
        addBarItems(PersonalViewController(), img: "tab_person", title: "我的")
        
        delegate = self
        
        title = tabs[0]
    }
    
    func addBarItems(child: UIViewController, img: String, title: String) {
        child.tabBarItem.image = UIImage(named: img)
        child.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        tabs.append(title)
        addChildViewController(child)
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        title = tabs[tabBarController.selectedIndex]
    }
}
