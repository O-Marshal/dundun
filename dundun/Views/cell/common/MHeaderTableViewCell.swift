//
//  MHeaderTableViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MHeaderTableViewCell: UITableViewCell {
    
    let labView1 = UILabel()
    let labView2 = UILabel()
    
    let numView1 = UILabel()
    let numView2 = UILabel()
    
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        labView1.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(15)
            make.centerX.equalTo(self).multipliedBy(0.5)
        }
        labView2.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(labView1)
            make.centerX.equalTo(self).multipliedBy(1.5)
        }
        numView1.addTo(self).snp_makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-10)
            make.centerX.equalTo(labView1)
        }
        numView2.addTo(self).snp_makeConstraints { (make) in
            make.bottom.equalTo(numView1)
            make.centerX.equalTo(labView2)
        }
        
        let line = UIView().withBack(MColor.lineUserInfoColor).addTo(self)
        line.snp_makeConstraints { (make) in
            make.center.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.8)
            make.width.equalTo(MSize.defaultSize.px(1))
        }
        
    }
    
    func setLab(lab1: String, lab2: String) {
        labView1.text = lab1
        labView2.text = lab2
    }
    
    func setData(num1: String, num2: String) {
        numView1.text = num1
        numView2.text = num2
    }
    
    private func initView() {
        selectionStyle = .None
        backgroundColor = UIColor.whiteColor()
        
        labView1.font = UIFont(name: "Heiti SC", size: 18)
        labView2.font = UIFont(name: "Heiti SC", size: 18)
        
        labView1.textColor = MColor.textHeaderColor
        labView2.textColor = MColor.textHeaderColor
        
        numView1.font = UIFont(name: "Heiti SC", size: 25)
        numView2.font = UIFont(name: "Heiti SC", size: 25)
        
        numView1.textColor = MColor.infoErrorColor
        numView2.textColor = MColor.infoErrorColor
    }
    

}
