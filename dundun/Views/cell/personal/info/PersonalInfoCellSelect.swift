//
//  PersonalInfoCellSelect.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

protocol PersonalInfoCellSelectProtocol {
    func selectedItem(selected: Int)
}

class PersonalInfoCellSelect: UITableViewCell {
    
    let labView = UILabel()
    let btn1 = UIButton()
    let btn2 = UIButton()
    
    var delegate: PersonalInfoCellSelectProtocol?
    
    func initView() {
        selectionStyle = .None
        
        labView.text = "性别"
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: autoSize(16, max: 18))
        addSubview(labView)
        
        btn1.setAttributedTitle(attributeString("男"), forState: .Normal)
        btn2.setAttributedTitle(attributeString("女"), forState: .Normal)
        
        btn1.backgroundColor = MColor.themeColor
        btn2.backgroundColor = MColor.buttonDisableColor
        
        addSubview(btn1.withAction(self, selector: #selector(touchEvent)))
        addSubview(btn2.withAction(self, selector: #selector(touchEvent)))
        
    }
    
    func setData(sex: Int, delegate: PersonalInfoCellSelectProtocol) {
        changeBtn(sex)
        self.delegate = delegate
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        
        labView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(40)
            make.centerY.equalTo(self)
        }
        
        btn1.snp_makeConstraints { (make) in
            make.left.equalTo(labView.snp_right).offset(50)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        
        btn2.snp_makeConstraints { (make) in
            make.left.equalTo(btn1.snp_right).offset(30)
            make.centerY.width.height.equalTo(btn1)
        }
        
        Line.defaultLine(20, right: 0, color: MColor.lineUserInfoColor).addTo(self)
    }
    
    func attributeString(title: String) -> NSAttributedString {
        return NSAttributedString(string: title, attributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: autoSize(13, max: 15))!, NSForegroundColorAttributeName: UIColor.whiteColor()])
    }
    
    func touchEvent(sender: UIButton) {
        changeBtn(sender == btn1 ? 0 : 1)
    }
    
    func changeBtn(i: Int) {
        if i == 0 {
            btn1.backgroundColor = MColor.themeColor
            btn2.backgroundColor = MColor.buttonDisableColor
            delegate?.selectedItem(0)
        } else {
            btn2.backgroundColor = MColor.themeColor
            btn1.backgroundColor = MColor.buttonDisableColor
            delegate?.selectedItem(1)
        }
    }
    

}
