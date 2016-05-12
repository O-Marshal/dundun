//
//  WalletChartView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/24.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

typealias WalletChartTup = (label: String, value: CGFloat)

class WalletChartView: UIView {
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.top.equalTo(80)
            make.width.equalTo(superview!)
            make.height.equalTo(240)
        }
        
        let titleLab = UILabel()
        titleLab.font = UIFont(name: "Heiti SC", size: 16)
        titleLab.text = "资产分析"
        titleLab.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(20)
        }
        
        backgroundColor = UIColor.whiteColor()
    }
    
    func setData(datas: [WalletChartTup]) {
        self.datas = datas
        setNeedsDisplay()
    }
    
    var datas: [WalletChartTup] = [
        ("盾盾卡卷", 21.98),
        ("返现", 890.20),
        ("系统分红", 20.08),
        ("邀请奖励", 98.23),
        ("签到奖励", 100.89)
    ]
}

// MARK: - 界面绘制
extension WalletChartView {
    
    override func drawRect(rect: CGRect) {
        
        let sum = datas.map({ $0.value }).reduce(0, combine: +)
        
        
        let ctx = UIGraphicsGetCurrentContext()
        let y:CGFloat = self.frame.height / 2 // 圆心 Y
        let r = min(self.frame.width / 4, y) - 35 // 半径 R
        let x = self.frame.width / 3.5 // 圆心 X
        
        // 画label
        let fontAttribute = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 18)!, NSForegroundColorAttributeName: MColor.textPlacholderColor]
        let fontSize = NSString(string: "总收入").sizeWithAttributes(fontAttribute)
        NSString(string: "总收入").drawAtPoint(CGPoint(x: x - fontSize.width / 2 ,y: y - fontSize.height / 2 - 10), withAttributes: fontAttribute)
        
        let numStr = String(format: "%.2f", sum)
        
        let NumfontAttribute = [NSFontAttributeName: UIFont(name: "Heiti SC", size: 18)!, NSForegroundColorAttributeName: MColor.textHeaderColor]
        let NumfontSize = NSString(string: numStr).sizeWithAttributes(NumfontAttribute)
        NSString(string: numStr).drawAtPoint(CGPoint(x: x - NumfontSize.width / 2 ,y: y - NumfontSize.height / 2 + 10), withAttributes: NumfontAttribute)
        
        //画图形
        var startAngle:CGFloat = 0
        for i in 0  ..< datas.count {
            // 计算每组占用的比例
            let scale:CGFloat = datas[i].value / sum
            UIColor(red: CGFloat(random() % 100) / 100, green: CGFloat(random() % 100) / 100, blue: CGFloat(random() % 100) / 100, alpha: 1).set()
            // 计算结束的位置
            let endAngle = startAngle + CGFloat.init(scale * 2 * CGFloat.init( M_PI));
            // 画弧
            CGContextSetLineWidth(ctx, 15)
            CGContextAddArc(ctx, x, y, r, startAngle, endAngle, 0);
            // 渲染
            CGContextDrawPath(ctx,CGPathDrawingMode.Stroke)
            
            drawLabel(ctx!, index: i)
            
            // 重新设置起始的位置，供一次循环使用
            startAngle = endAngle
        }
    }
    
    func drawLabel(context: CGContextRef, index: Int) {
        let y = 40 + CGFloat(index) * 35
        
        // 绘制圆点
        CGContextAddEllipseInRect(context, CGRect(x: 225, y: y + 5, width: 10, height: 10))
        CGContextFillPath(context)
        
        // 绘制标签
        let strRect = CGRect(x: 250, y: y, width: 80, height: 20)
        NSString(string: datas[index].label).drawInRect(strRect, withAttributes: [NSFontAttributeName: UIFont.systemFontOfSize(16), NSForegroundColorAttributeName: MColor.textPlacholderColor])
        
        // 绘制数量
        let numRect = CGRect(x: 330, y: y, width: 50, height: 20)
        NSString(string: "\(datas[index].value)").drawInRect(numRect, withAttributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: 16)!, NSForegroundColorAttributeName: MColor.textHeaderColor])
    }
    
    func drawTitle(context: CGContextRef, index: Int) {
        let y = 40 + CGFloat(index) * 35
        
        // 绘制圆点
        CGContextAddEllipseInRect(context, CGRect(x: 225, y: y + 5, width: 10, height: 10))
        CGContextFillPath(context)
        
        // 绘制标签
        let strRect = CGRect(x: 250, y: y, width: 80, height: 20)
        NSString(string: datas[index].label).drawInRect(strRect, withAttributes: [NSFontAttributeName: UIFont.systemFontOfSize(16), NSForegroundColorAttributeName: MColor.textPlacholderColor])
        
        // 绘制数量
        let numRect = CGRect(x: 330, y: y, width: 50, height: 20)
        NSString(string: "\(datas[index].value)").drawInRect(numRect, withAttributes: [NSFontAttributeName: UIFont(name: "Heiti SC", size: 16)!, NSForegroundColorAttributeName: MColor.textHeaderColor])
    }
    
}
