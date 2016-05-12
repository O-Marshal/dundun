//
//  IndentFlowView.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

//let labelFont = UIFont.boldSystemFontOfSize(18)
class IndentFlowView: UIView {
    let themColor = UIColor(red: 0.4, green: 0.6, blue: 1, alpha: 1)
    var circleView = CircleView()
    var AffirmLabel = UILabel()
    var PayLabel = UILabel()
    var sellerDeliverLabel = UILabel()
    var AffirmReceiveLabel = UILabel()
    var line1Color = UIColor()
    var line2Color = UIColor()
    var line3Color = UIColor()
    
    override func didMoveToSuperview() {
        if superview == nil { return }
       // 得到margin
        let margin = self.getMargin()
        
        // 四个订单流程的label
        let AffirmLabel = self.createLabel("订单确认", referenceView: self, margin: margin,color: UIColor.blueColor())
        self.AffirmLabel = AffirmLabel
        
        let PayLabel = self.createLabel("订单支付", referenceView: AffirmLabel, margin: margin, color: UIColor.grayColor())
        self.PayLabel = PayLabel
        
        let sellerDeliverLabel = self.createLabel("卖家发货", referenceView: PayLabel, margin: margin, color: UIColor.grayColor())
        self.sellerDeliverLabel = sellerDeliverLabel
        
        let AffirmReceiveLabel = self.createLabel("确认收货", referenceView: sellerDeliverLabel, margin: margin, color: UIColor.grayColor())
        self.AffirmReceiveLabel = AffirmReceiveLabel
        
        self.addSubview(circleView.initGroup(themColor))
        circleView.snp_makeConstraints { (make) in
            make.centerX.equalTo(AffirmLabel)
            make.top.equalTo(AffirmLabel.snp_bottom).offset(10)
            make.size.equalTo(CGSizeMake(8, 8))
        }
        // 三个view(线 + 圆点)
       self.createLineView(AffirmLabel, margin: margin,color: line1Color)
       self.createLineView(PayLabel, margin: margin,color: line2Color)
       self.createLineView(sellerDeliverLabel, margin: margin,color: line3Color)
        
        
    }
    /**
     线和点结合的view创建
     - parameter AffirmLabel: 参考物:流程label
     - parameter margin:      margin
     - returns: 返回view
     */
    func createLineView(AffirmLabel: UIView, margin: CGFloat?, color: UIColor?){
       
        let lineView = UIView()
        self.addSubview(lineView)
        lineView.snp_makeConstraints { (make) in
            make.left.equalTo(AffirmLabel.snp_centerX).offset(3 + 5)
            make.top.equalTo(AffirmLabel.snp_bottom).offset(10 )
            make.width.equalTo(AffirmLabel.snp_width).offset( -margin! - 2)
            make.height.equalTo(8.5)
        }
        let line1 = UIView()
        line1.transform = CGAffineTransformMakeScale(1, 0.5)
        line1.backgroundColor = color!
        lineView.addSubview(line1)
        line1.snp_makeConstraints { (make) in
            make.left.equalTo(lineView)
            make.top.equalTo(lineView).offset(5)
            make.height.equalTo(1)
            make.width.equalTo(lineView).offset(-13)
        }
        let circle = CircleView()
        
        lineView.addSubview(circle.initGroup(color!))
        circle.snp_makeConstraints { (make) in
            make.right.equalTo(lineView)
            make.top.equalTo(lineView)
            make.size.equalTo(CGSizeMake(8, 8))
        }
      
    }
    /**
     订单流程label的创建
     - parameter text:          label文字
     - parameter referenceView: 参考物
     - parameter margin:        margin
     - parameter color:         文字颜色
     - returns: 返回label
     */
    func createLabel(text: String, referenceView: UIView?, margin: CGFloat?, color: UIColor?) ->UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = labelFont
        label.textColor = color
        self.addSubview(label)
        label.snp_makeConstraints { (make) in
            make.top.equalTo(self).offset(20)
            referenceView == self ? make.left.equalTo(self).offset(-margin!) : make.left.equalTo(referenceView!.snp_right).offset(-margin!)
                    }
        return label
    }
    func getMargin() -> CGFloat {
        let text = UILabel()
        text.text = "订单确认"
        text.font = labelFont
        var margin = text.attributedText?.boundingRectWithSize(CGSizeMake(80, CGFloat.max), options:.UsesLineFragmentOrigin, context: nil).size.width
        margin = (self.frame.size.width - 4 * margin!) / (4 + 1) + 15
        return margin!
    }
}
