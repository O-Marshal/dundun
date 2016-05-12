//
//  PersonalAdrCellNew.swift
//  dundun
//
//  Created by 刘荣 on 16/4/24.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
protocol PersonalAdrCellNewProtocol {
    func textChange(text: String?, identify: String?)
}

class PersonalAdrCellNew: UITableViewCell {
    
    let labView = UILabel()
    let textField = UITextField()
    let textView = UITextView()
    
    var delegate: PersonalAdrCellNewProtocol?
    
    var identify: String?
    
    var isTV = false
    
    func initView(lab: String, plach: String, identify: String?) {
        
        selectionStyle = .None
        
        self.identify = identify
        
        labView.text = lab
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: autoSize(16, max: 18))
        labView.textAlignment = .Right
        addSubview(labView)
        
        let atrString = NSAttributedString(string: plach, attributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: autoSize(16, max: 18))!, NSForegroundColorAttributeName: MColor.textPlacholderColor])
        
        textField.text = nil
        textField.attributedPlaceholder = atrString
        textField.addTarget(self, action: #selector(textChange(_:)), forControlEvents: .EditingChanged)
        textView.delegate = self
        
        textView.textAlignment = .Natural
        textView.attributedText = atrString
        textView.text = nil
        
        addSubview(textField)
        addSubview(textView)
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        labView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.width.equalTo(80)
            make.centerY.equalTo(self)
        }
        if isTV {
            textView.snp_makeConstraints { (make) in
                make.left.equalTo(labView.snp_right).offset(20)
                make.right.equalTo(self).offset(-20)
                make.height.equalTo(self).offset(-10)
                make.centerY.equalTo(self)
            }
        } else {
            textField.snp_makeConstraints { (make) in
                make.left.equalTo(labView.snp_right).offset(20)
                make.right.equalTo(self).offset(-20)
                make.centerY.equalTo(self)
            }
        }
        
        Line.defaultLine(10, right: 0, color: MColor.lineUserInfoColor).addTo(self)
    }
    
    func textChange(textField: UITextField) {
        delegate?.textChange(textField.text, identify: identify)
    }
    
}

extension PersonalAdrCellNew: UITextViewDelegate {
    func textViewDidChange(textView: UITextView) {
        delegate?.textChange(textView.text, identify: identify)
    }
}
