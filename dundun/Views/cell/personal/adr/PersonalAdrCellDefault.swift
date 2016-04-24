//
//  PersonalAdrCellDefault.swift
//  dundun
//
//  Created by 刘荣 on 16/4/24.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class PersonalAdrCellDefault: UITableViewCell {
    
    let nameView = UILabel()
    let phoView = UILabel()
    let adrView = UILabel()
    
    let imgView = UIButton()
    
    var void: ((index: Int)->Void)?
    
    var index = 0
    
    func initView(void: ((index: Int)->Void)?) {
        
        selectionStyle = .None
        
        self.void = void
        
        nameView.text = "啊实打实"
        phoView.text = "123123123"
        adrView.text = "三大快拉上你的老卡死卡了呢阿萨德那算快乐的"
        
        nameView.font = UIFont.boldSystemFontOfSize(16)
        nameView.textColor = MColor.textHeaderColor
        
        phoView.font = UIFont(name: "Heiti SC", size: 16)
        adrView.font = UIFont(name: "Heiti SC", size: 16)
        phoView.textColor = MColor.textPlacholderColor
        adrView.textColor = MColor.textPlacholderColor
        
        adrView.numberOfLines = 2
        
        imgView.withAction(self, selector: #selector(touchEvent)).setImage(UIImage(named: "user_adr_edit"), forState: .Normal)
        addSubview(nameView)
        addSubview(phoView)
        addSubview(adrView)
        addSubview(imgView)
    }
    
    func setData(model: PersoanlAddressModel, index: Int) {
        nameView.text = model.name
        phoView.text = model.pho
        adrView.text = model.adr
        self.index = index
    }
    
    func touchEvent() {
        if let v = void {
            return v(index: index)
        }
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        
        imgView.snp_makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.centerY.equalTo(self)
            make.right.equalTo(-20)
        }
        
        nameView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(40)
            make.top.equalTo(10)
        }
        phoView.snp_makeConstraints { (make) in
            make.right.equalTo(imgView.snp_left).offset(-20)
            make.top.equalTo(10)
        }
        adrView.snp_makeConstraints { (make) in
            make.left.equalTo(nameView)
            make.right.equalTo(phoView)
            make.top.equalTo(nameView.snp_bottom).offset(10)
        }
        
        
    }

}
