//
//  MSize.swift
//  dundun
//
//  Created by 刘荣 on 16/4/11.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

/// 公共尺寸
class MSize {
    
    var frame: CGRect
    var size: CGSize
    var width: CGFloat
    var height: CGFloat
    
        /// 屏幕缩放比例
    var scale: CGFloat
    
    static let defaultSize = MSize()
    
    private init() {
        let screen = UIScreen.mainScreen()
        frame = screen.bounds
        size = frame.size
        width = size.width
        height = size.height
        
        scale = screen.scale
    }
    
    func px(size: Int) -> CGFloat {
        return CGFloat(size) / scale + 0.1
    }
    
    func scrollHeight(height: CGFloat) -> CGFloat {
        if height > self.height { return height + 10 }
        return self.height + 10
    }
}
