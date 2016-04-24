//
//  ActiveViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class ActiveViewController: BaseViewController {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        showViewController(ViewController(), sender: nil)
    }
    
}
