//
//  GoodsViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class GoodsViewController: BaseViewController {
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        showViewController(IndentViewController(), sender: nil)
    }
}
