//
//  ExtensionButton.swift
//  dundun
//
//  Created by 刘荣 on 16/4/20.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

extension UIButton {
    
    func withAction(target: AnyObject, selector: Selector) -> UIButton {
        addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        return self
    }

}
