//
//  QRCodeWrapView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/19.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class QRCodeWrapView: UIView {
    
    override func drawRect(rect: CGRect) {
        let frame = CGRect(x: self.frame.width / 2 - 125, y: 100, width: 250, height: 250)
        UIColor(white: 0, alpha: 0).setFill()
        UIRectFill(frame)
    }

}