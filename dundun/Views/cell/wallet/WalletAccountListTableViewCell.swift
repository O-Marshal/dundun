//
//  WalletAccountListTableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class WalletAccountListTableViewCell: UITableViewCell {
    
    let imgView = UIImageView()
    
    let labView = UILabel()
    let dscView = UILabel()
    
    let numView = UILabel()
    let timeView = UILabel()
    
    var isNext = false
    
    func initView() {
        
        selectionStyle = .None
        
        imgView.image = UIImage(named: "icon_imageLoading")
        
        labView.text = "***的什么小店"
        dscView.text = "本店主营：化妆品，沐浴露，洗发水阿萨德就看你撒即可到你家卡三打卡上了..."
        
        labView.textColor = MColor.textLabelColor
        dscView.textColor = MColor.textPlacholderColor
        
        labView.font = UIFont.systemFontOfSize(18)
        dscView.font = UIFont.systemFontOfSize(16)
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        imgView.addTo(self).snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.height.equalTo(40)
            make.centerY.equalTo(self)
        }
        
        labView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(imgView).offset(-5)
            make.left.equalTo(imgView.snp_right).offset(20)
            make.right.equalTo(-20)
        }
        dscView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(labView.snp_bottom).offset(5)
            make.left.equalTo(labView)
            make.right.equalTo(-20)
        }
    }

}
