//
//  Line.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class Line: UIView {
    
    var left: CGFloat = 0
    var right: CGFloat = 0
    
    
    class func defaultLine(offset: CGFloat, color: UIColor = UIColor.whiteColor()) -> UIView {
        let v = Line()
        v.left = offset
        v.right = offset
        v.backgroundColor = color
        return v
    }
    class func defaultLine(left: CGFloat, right: CGFloat, color: UIColor = UIColor.whiteColor()) -> UIView {
        let v = Line()
        v.left = left
        v.right = right
        v.backgroundColor = color
        return v
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.left.equalTo(superview!).offset(left)
            make.right.equalTo(superview!).offset(-right)
            make.height.equalTo(MSize.defaultSize.px(1))
            make.bottom.equalTo(superview!)
        }
    }

}
