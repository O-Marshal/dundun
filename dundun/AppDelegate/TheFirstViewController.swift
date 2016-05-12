//
//  TheFirstViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/10.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit

class TheFirstViewController: UIViewController {
    
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        let backColor = UIColor(red: 99/255, green: 147/255, blue: 246/255, alpha: 1)
        scrollView.addTo(view).withBack(backColor).frame = view.frame
        scrollView.pagingEnabled = true
        
        let width = view.frame.width
        let height = view.frame.height
        for i in 1...3 {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "f\(i).jpeg")
            imageView.contentMode = .ScaleAspectFill
            imageView.backgroundColor = backColor
            imageView.frame = CGRect(x: width * (CGFloat(i) - 1), y: 0, width: width , height: height)
            scrollView.addSubview(imageView)
            if i == 3 {
                imageView.addTapEvent(self, action: #selector(touchEvent))
            }
        }
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentSize = CGSize(width: width * 3, height: 0)
    }
    
    func touchEvent() {
        let dundun = NSUserDefaults.standardUserDefaults()
        dundun.setBool(true, forKey: "app_first")
        dundun.synchronize()
        showViewController(MNavigationController(rootViewController: MTabBarController.defaultTabBar), sender: nil)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
