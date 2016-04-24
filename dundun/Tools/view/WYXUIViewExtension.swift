//
//  WYXUIViewExtension.swift
//  dundun
//
//  Created by 刘荣 on 16/4/24.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

extension UIView {
    //wyxuan --add --画分割线
    func cellLine(superView:UIView ,tag:Int, height:Int, color:UIColor) -> UIView{
        let line = UIView()
        line.backgroundColor = color
        line.tag = tag
        superView.addSubview(line)
        //布局
        line.snp_makeConstraints { (make) -> Void in
            make.left.right.bottom.equalTo(superView)
            make.height.equalTo(height)
        }
        return line
    }
}
