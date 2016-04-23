//
//  ExtensionUIImage.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

//  渲染图片颜色
extension UIImage {
    func whiteImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, .Normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        CGContextClipToMask(context, rect, self.CGImage)
        UIColor.whiteColor().setFill()
        CGContextFillRect(context, rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func image(color: UIColor, backgroundColor: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(context, 0, self.size.height)
        CGContextScaleCTM(context, 1.0, -1.0)
        CGContextSetBlendMode(context, .Normal)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        CGContextClipToMask(context, rect, self.CGImage)
        color.setFill()
        backgroundColor.setStroke()
        CGContextFillRect(context, rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}