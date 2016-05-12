//
//  PersonalAboutViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/10.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit

class PersonalAboutViewController: BaseViewController {
    
    override func initView() {
        title = "关于盾盾"
        
        let logoView = UIImageView()
        logoView.image = UIImage(named: "icon_logo")
        logoView.addTo(view).snp_makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(60)
            make.width.height.equalTo(100)
        }
        
        let labView = UILabel()
        labView.text = "盾盾 2.0"
        labView.textColor = MColor.textPlacholderColor
        labView.font = UIFont.boldSystemFontOfSize(18)
        labView.addTo(view).snp_makeConstraints { (make) in
            make.top.equalTo(logoView.snp_bottom).offset(20)
            make.centerX.equalTo(view)
        }
        view.backgroundColor = UIColor.whiteColor()
        
        let infoView = UILabel()
        infoView.numberOfLines = 0
        infoView.text = "盾盾 全新改版，商城上线，盾盾基金，全新业务"
        infoView.textColor = MColor.textPlacholderColor
        infoView.font = UIFont(name: "Heiti SC", size: 14)
        infoView.addTo(view).snp_makeConstraints { (make) in
            make.bottom.equalTo(view.snp_bottom).offset(-40)
            make.left.equalTo(view).offset(40)
            make.right.equalTo(view).offset(-40)
        }
        infoView.textAlignment = .Center
    }

}
