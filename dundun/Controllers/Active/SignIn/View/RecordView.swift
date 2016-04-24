//
//  RecordView.swift
//  mySwift
//
//  Created by students on 16/4/11.
//  Copyright © 2016年 王允顶. All rights reserved.
//

import UIKit

class RecordView: UIView {

    var _record : Record?
    let title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = controlColour
        
        title.textAlignment = NSTextAlignment.Left
        self.addSubview(title)
        title.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self).offset(10)
            make.left.equalTo(self).offset(20)
            make.bottom.equalTo(self).offset(-10)
//            make.width.equalTo(150)
        }
        
    }
    func record(record : Record)
    {
        _record = record
        title.text = record.title
        switch record.tag
        {
        case 0:
            let numLabel = UILabel()
            numLabel.textAlignment = NSTextAlignment.Left
            self.addSubview(numLabel)
            numLabel.text = record.num
            numLabel.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(self).offset(10)
                make.bottom.equalTo(self).offset(-10)
                make.width.equalTo(150)
                make.left.equalTo(title.snp_right).offset(10)
            })
            break
        case 1:
            let btn = UIButton(type: UIButtonType.Custom)
            self.addSubview(btn)
            btn.setBackgroundImage(UIImage(named: "right@32"), forState: UIControlState.Normal)
            btn.addTarget(self, action: "btnTouch", forControlEvents: .TouchUpInside)
            btn.snp_makeConstraints(closure: { (make) -> Void in
                make.top.equalTo(self).offset(10)
                make.bottom.equalTo(self).offset(-10)
                make.right.equalTo(self).offset(-10)
            })
            break
        default:
            break
        }
    }
    
    func btnTouch()
    {
        print("right")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
