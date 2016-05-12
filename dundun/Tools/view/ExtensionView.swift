
//
//  ExtensionView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

extension UIView {
    
    func addTo(view: UIView) -> UIView {
        view.addSubview(self)
        return self
    }
    
    func withBack(color: UIColor) -> UIView {
        backgroundColor = color
        return self
    }
    
    func addTapEvent(target: AnyObject?, action: Selector) {
        userInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: action)
        addGestureRecognizer(tap)
    }
    
    var imageView: UIImageView {
        return self as! UIImageView
    }
    
    var btnView: UIButton {
        return self as! UIButton
    }
    
    var labelView: UILabel {
        return self as! UILabel
    }

}
