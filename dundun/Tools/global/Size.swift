//
//  Size.swift
//  dundun
//
//  Created by 刘荣 on 16/4/21.
//  Copyright © 2016年 Microali. All rights reserved.
//

import Foundation

func autoSize(min: CGFloat, max: CGFloat) -> CGFloat {
    return MSize.defaultSize.autoSize(min, max: max)
}
