//
//  WebViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/25.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit

class WebViewController: BaseViewController {
    
    let webView = UIWebView()
    var url = ""
    
    
    override func initView() {
        webView.addTo(view).snp_makeConstraints { (make) in
            make.size.equalTo(view)
        }
        let btn = UIButton()
        btn.withAction(self, selector: #selector(share)).setImage(UIImage(named: "nav_share"), forState: .Normal)
        btn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
        
    }
    
    override func initEvent() {
        webView.loadRequest(NSURLRequest(URL: NSURL(string: url)!))
    }
    
    func share() {
        let shareView = UMShareView.defaultView
        shareView.shareWeb(self, tit: title ?? "盾盾", text: "盾盾2.0-全新商城上线，盾盾基金，让您买买买-花无忧", img: "icon_logo", url: "http://dundun.mog.name/share")
        shareView.show()
    }

}
