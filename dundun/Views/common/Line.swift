//
//  Line.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class Line: UIView {
    
    var offset: CGFloat = 0
    
    
    class func defaultLine(offset: CGFloat, color: UIColor = UIColor.whiteColor()) -> UIView {
        let v = Line()
        v.offset = offset
        v.backgroundColor = color
        return v
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.left.equalTo(superview!).offset(offset)
            make.right.equalTo(superview!).offset(-offset)
            make.height.equalTo(MSize.defaultSize.px(1))
            make.bottom.equalTo(superview!).offset(-1)
        }
    }

}
