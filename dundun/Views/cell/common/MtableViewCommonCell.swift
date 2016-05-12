//
//  MtableViewCommonCell.swift
//  dundun
//
//  Created by 刘荣 on 16/4/30.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MtableViewCommonCell: UITableViewCell {
    
    let imgView = UIImageView()
    
    let labView = UILabel()
    let dscView = UILabel()
    
    let numView = UILabel()
    let timeView = UILabel()
    
    var isNext = false
    var notNum = false
    var model: MtableViewCommonModel?
    
    func setAccount(model: MtableViewCommonModel) {
        self.model = model
        
        imgView.image = UIImage(named: model.icon)
        
        labView.text = model.title
        dscView.text = model.desc
        
        numView.text = model.numStr
        timeView.text = model.time
    }
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        imgView.addTo(self).snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.height.equalTo(40)
            make.centerY.equalTo(self)
        }
        // 先设置右边
        if notNum { // 没有金额
            timeView.addTo(self).snp_makeConstraints(closure: { (make) in
                make.centerY.equalTo(self)
                make.right.equalTo(self).offset( isNext ? -35 : -10)
                make.width.equalTo(80)
            })
        } else {
            if model?.money ?? 0 >= 0 {
                numView.textColor = MColor.themeColor
            } else {
                numView.textColor = MColor.infoErrorColor
            }
            numView.addTo(self).snp_makeConstraints(closure: { (make) in
                make.top.equalTo(imgView).offset(-5)
                make.right.equalTo(self).offset(-10)
                make.width.equalTo(80)
            })
            timeView.addTo(self).snp_makeConstraints(closure: { (make) in
                make.top.equalTo(numView.snp_bottom).offset(5)
                make.right.equalTo(self.snp_right).offset(-10)
                make.width.equalTo(80)
            })
        }
        
        if model!.hasDesc {
            labView.addTo(self).snp_makeConstraints { (make) in
                make.top.equalTo(imgView).offset(-5)
                make.left.equalTo(imgView.snp_right).offset(20)
                make.right.equalTo(timeView.snp_left)
            }
            dscView.addTo(self).snp_makeConstraints { (make) in
                make.top.equalTo(labView.snp_bottom).offset(5)
                make.left.equalTo(labView)
                make.right.equalTo(timeView.snp_left)
            }
        } else {
            labView.addTo(self).snp_makeConstraints { (make) in
                make.centerY.equalTo(self)
                make.left.equalTo(imgView.snp_right).offset(20)
                make.right.equalTo(timeView.snp_left)
            }
        }
        
        if isNext {
            let rightIcon = UIImageView(image: UIImage(named: "icon_right")).addTo(self)
            rightIcon.snp_makeConstraints { (make) in
                make.right.equalTo(self).offset(-10)
                make.centerY.equalTo(self)
            }
        }
    }
    
    private func initView() {
        
        selectionStyle = .None
        
        numView.textAlignment = .Right
        timeView.textAlignment = .Right
        
        labView.textColor = MColor.textLabelColor
        dscView.textColor = MColor.textPlacholderColor
        timeView.textColor = MColor.textPlacholderColor
        
        labView.font = UIFont.systemFontOfSize(18)
        dscView.font = UIFont.systemFontOfSize(16)
        
        numView.font = UIFont.systemFontOfSize(18)
        timeView.font = UIFont.systemFontOfSize(16)
    }

}
