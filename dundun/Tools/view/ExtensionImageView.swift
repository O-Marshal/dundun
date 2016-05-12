//
//  ExtensionImageView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/25.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

extension UIImageView {
    
    var m_AspectFillImageView: UIImageView {
        contentMode = .ScaleAspectFill
        return self
    }

}
