//
//  CircleView.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/8.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class CircleView: UIView {
    let themColor = UIColor(red: 0.4, green: 0.6, blue: 1, alpha: 1)
    var fillColor:UIColor?
    
    
    func initGroup(color: UIColor?) -> CircleView {
       
        self.backgroundColor = UIColor.whiteColor()
        self.fillColor = color
        return self
    }
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()

        CGContextAddEllipseInRect(context, CGRectMake(0, 0, 8, 8))
        CGContextSetFillColorWithColor(context, fillColor!.CGColor)
       CGContextFillPath(context)
        
    }
}
