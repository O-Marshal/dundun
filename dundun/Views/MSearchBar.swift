//
//  MSearchBar.swift
//  dundun
//
//  Created by 刘荣 on 16/4/28.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit

class MSearchBar: UISearchBar {
    
    class var searchBar: UISearchBar {
        let searchBar = MSearchBar()
        return searchBar
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        barTintColor = MColor.backgroundColor
        searchBarStyle = .Minimal
        placeholder = "搜索"
        frame = CGRect(origin: superview!.frame.origin, size: CGSize(width: superview!.frame.width, height: 50))
        translucent = true
    }
}