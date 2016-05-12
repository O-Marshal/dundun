//
//  ExtensionTextField.swift
//  dundun
//
//  Created by 刘荣 on 16/5/10.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

extension UITextField {
    
    override func addTo(view: UIView) -> UITextField {
        view.addSubview(self)
        return self
    }
}
