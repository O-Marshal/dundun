//
//  AssetsView.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/11.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

class AssetsView: UIView {
    //盾盾卡卷
    let card = UILabel()
    //返现
    let cashback = UILabel()
    //系统分红
    let receive = UILabel()
    //邀请奖励
    let invitation = UILabel()
    //签到奖励
    let signin = UILabel()
    //总资产
    var total:CGFloat?
    //资产各个值
    var list:[CGFloat] = []
    //字体
    let fontTitle = UIFont.systemFontOfSize(15)
    let fontLable = UIFont.systemFontOfSize(13)
    let lineColor = UIColor(red: 0.93, green: 0.95, blue: 1.00, alpha: 1.00)
    let colorList:[UIColor] = [
        UIColor(red: 0.18, green: 0.60, blue: 0.85, alpha: 1.00),
        UIColor(red: 0.88, green: 0.37, blue: 0.27, alpha: 1.00),
        UIColor(red: 0.53, green: 0.77, blue: 0.91, alpha: 1.00),
        UIColor(red: 0.41, green: 0.93, blue: 0.10, alpha: 1.00),
        UIColor(red: 0.98, green: 0.72, blue: 0.16, alpha: 1.00)
        ]
    
    //创建子视图
    func createView(){
        
        let title = UILabel(frame: CGRect(x: 10, y: 0, width: 100, height: 30))
        title.text = "资产分析"
        title.font = fontTitle
        self.addSubview(title)
        createLable("cardvolume_assets_signin", title: "签到奖励", valueLable: signin, referView:self)
        createLable("cardvolume_assets_invitation", title: "邀请奖励", valueLable: invitation, referView:signin)
        createLable("cardvolume_assets_receive", title: "系统分红", valueLable: receive, referView: invitation)
        createLable("cardvolume_assets_cashback", title: "返       现", valueLable: cashback, referView:receive)
        createLable("cardvolume_assets_card", title: "盾盾卡卷", valueLable: card, referView:cashback)
        cellLine(self, tag: 101, height: 10, color: lineColor)
    }
    //setData
    func setWalletHomeData(data:WalletHomeModel){
        total = data.m1 + data.m2 + data.m3 + data.m4 + data.m5
        list.append(data.m1)
        list.append(data.m2)
        list.append(data.m3)
        list.append(data.m4)
        list.append(data.m5)
        card.text = String(data.m1)
        cashback.text  = String(data.m2)
        receive.text = String(data.m3)
        invitation.text = String(data.m4)
        signin.text = String(data.m5)
        self.setNeedsDisplay()
        
    }
    
    /**创建资产分析右侧数据栏并自动布局：imageName图标名称，title标题，valueLable资产值，referView布局参照视图*/
    func createLable(imageName:String, title:String, valueLable:UILabel, referView:UIView){
       let imageView = UIImageView(image: UIImage(named: imageName))
       self.addSubview(imageView)
       let titleLable = UILabel()
        titleLable.text = title
        titleLable.font = fontLable
        titleLable.textColor = UIColor.grayColor()
       self.addSubview(titleLable)
       self.addSubview(valueLable)
       valueLable.textAlignment = NSTextAlignment.Left
       valueLable.textColor = UIColor.grayColor()
       valueLable.font = UIFont.systemFontOfSize(13)
        
       valueLable.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(referView.snp_right)
            make.bottom.equalTo(referView.snp_bottom).offset(-25)
            make.width.equalTo(70)
            make.height.equalTo(15)
        }
        titleLable.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(valueLable.snp_left).offset(-10)
            make.bottom.equalTo(valueLable.snp_bottom)
            make.width.equalTo(60)
            make.height.equalTo(15)
        }
        imageView.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(titleLable.snp_left).offset(-5)
            make.bottom.equalTo(valueLable.snp_bottom).offset(3)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
    }
    
    override func drawRect(rect: CGRect) {
        if list.count <= 0 {
            return
        }
        let ctx = UIGraphicsGetCurrentContext();
        let r = (self.frame.width - 90)/5.0
        let x = r+40
        let y:CGFloat = self.frame.height / 2
        //画图形
        var startAngle:CGFloat = 0;
        for var i=0 ; i<list.count; i += 1 {
            // 计算每组占用的比例
            let scale:CGFloat = list[i] / (total)!;
            colorList[i].set()
            // 计算结束的位置
            let endAngle = startAngle + CGFloat.init(scale * 2 * CGFloat.init( M_PI));
            // 画弧
            CGContextSetLineWidth(ctx, 15)
            CGContextAddArc(ctx, x, y, r, startAngle, endAngle, 0);
            // 渲染
            CGContextDrawPath(ctx,CGPathDrawingMode.Stroke)
            
            // 重新设置起始的位置，供一次循环使用
            startAngle = endAngle
        }
        
        let countReceive = UILabel(frame:CGRect(x: x-40, y: y-20, width: 80, height: 20))
        countReceive.text = "总资产"
        countReceive.font = fontLable
        countReceive.textAlignment = NSTextAlignment.Center
        self.addSubview(countReceive)
        let countReceiveNum = UILabel(frame:CGRect(x: x-40, y: y, width: 80, height: 20))
        countReceiveNum.textAlignment = NSTextAlignment.Center
        countReceiveNum.text = String( total! )
        countReceiveNum.font = fontLable
        countReceiveNum.textColor = UIColor.grayColor()
        self.addSubview(countReceiveNum)
    }
}
