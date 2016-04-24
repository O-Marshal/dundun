//
//  MButton.swift
//  dundun
//
//  Created by 刘荣 on 16/4/18.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class MButton: UIButton {
    
    class func themButton(title: String, target: UIViewController, action: Selector) -> MButton {
        let btn = MButton()
        btn.setTitle(title, forState: .Normal)
        btn.backgroundColor = MColor.themeColor
        btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return btn
    }
    
    class func whiteButton(title: String, target: UIViewController, action: Selector) -> MButton {
        let btn = MButton()
        btn.setTitle(title, forState: .Normal)
        btn.backgroundColor = UIColor.whiteColor()
        btn.setTitleColor(MColor.themeColor, forState: .Normal)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return btn
    }

    //wyxuan --add-begin
    typealias callbackfunc=()->Void
    var layout = callbackfunc?()
    func initBack(mathFunction:()->Void ){
        layout = mathFunction
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if (layout != nil){
            layout!()
        }
    }
    class func defaultButton(title:String, image:String ,action:Selector, target:AnyObject) -> MButton {
        let btn = MButton(type: .Custom)
        btn.setTitle(title, forState: .Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(14)
        btn.setImage(UIImage(named: image), forState: .Normal)
        btn.addTarget(target, action: action, forControlEvents: .TouchUpInside)
        return btn
    }
    //wyxuan --add-end
}

//wyxuan --add
extension UIButton{
    func verticallayout() {
        let width = self.frame.size.width
        self.imageView?.frame = CGRectMake(width / 4, 5, width / 2,(self.frame.size.height / 2 )-10)
        self.titleLabel?.frame = CGRectMake(0, (self.imageView?.frame.height)!, width, self.frame.size.height - (self.titleLabel?.frame.origin.y)!)
        self.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.titleLabel?.textAlignment = NSTextAlignment.Center
    }
    //lable左对齐，image右对齐
    func horizontalRightlayout(){
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left:self.frame.size.width-20, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -self.frame.size.width+40, bottom: 0, right: 0)
        self.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.titleLabel?.textAlignment = NSTextAlignment.Center
    }
    //lable与image有间距布局
    func horizontalSpacelayout(distance:CGFloat){
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -distance, bottom: 0, right: 0)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: distance, bottom: 0, right: 0)
        self.titleLabel?.font = UIFont.systemFontOfSize(14)
        self.titleLabel?.textAlignment = NSTextAlignment.Center
    }
}
//wyxuan --add --end

