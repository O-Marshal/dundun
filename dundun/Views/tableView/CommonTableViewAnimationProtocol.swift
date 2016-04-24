//
//  CommonTableViewAnimationProtocol.swift
//  dundun
//
//  Created by 刘荣 on 16/4/23.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

protocol CommonTableViewAnimationProtocol {
    
    var tableView: UITableView { get }
    
    func tableViewRelaod(contrary: Bool)

}

extension CommonTableViewAnimationProtocol {
    
    func tableViewRelaod(contrary: Bool = false) {
        tableView.alpha = 0
        tableView.reloadData()
        
        let tableWidth:CGFloat = contrary ? self.tableView.bounds.size.width : -self.tableView.bounds.size.width
        let cells:NSArray = self.tableView.visibleCells
        
        for a in 0 ..< cells.count {
            let cell:UITableViewCell = cells.objectAtIndex(a) as! UITableViewCell
            if(cell.isKindOfClass(UITableViewCell)){
                cell.transform = CGAffineTransformMakeTranslation(tableWidth, 0)
            }
        }
        
        self.tableView.alpha = 1.0
        var index = 0
        for b in cells{
            let cell: UITableViewCell = b as! UITableViewCell
            UIView.animateWithDuration(1.2, delay: 0.04 * Double(index), usingSpringWithDamping: 0.65, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: nil)
            index += 1
        }
    }
    
}
