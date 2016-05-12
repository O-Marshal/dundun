//
//  ShoppingListCell.swift
//  dundun
//
//  Created by 陈汉玉 on 16/4/8.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit



protocol totalProtocol {
    func changeTotal(total: String?, ints: Int)
}

class ShoppingListCell: UITableViewCell{
    var nameLabel = UILabel()
    var countLabel:UILabel?
    var i = 1
    var prices: Float = 0
    var howMuch = String()
    var delegate: totalProtocol?
    var model = MyIndentModel()
    var models: GoodsModel?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        
    }
    func applyRefund(){
        let refund = UIButton()
       
        var btnString = String()
        var labelString = String()
        var txtColor = white
        var BGColor = themColor
        
        if model.status == -1 {
            btnString = "订单取消"
            labelString = "查看订单"
        }
        if model.status == 0 {
            btnString = "付款"
            labelString = "待付款"
        }
        if model.status == 1 {
            btnString = "查看订单"
            labelString = "待发货"
        }
        if model.status == 2 {
            btnString = "查看物流"
            labelString = "待收货"
        }
        if model.status == 3 {
            btnString = "再来一单"
            labelString = "交易成功"
            txtColor = themColor
            BGColor = white
        }
         refund.backgroundColor = BGColor
      
        
        refund.setAttributedTitle(NSAttributedString.init(string: btnString, attributes: [NSFontAttributeName:UIFont.boldSystemFontOfSize(14), NSForegroundColorAttributeName:txtColor]), forState: .Normal)
        if model.status == 3 {
            refund.layer.borderColor = themColor.CGColor
            refund.layer.borderWidth = 1
            refund.layer.cornerRadius = 3
        }
        refund.withAction(self, selector: #selector(UIAlertView.show))
        contentView.addSubview(refund)
        refund.snp_makeConstraints { (make) in
            make.bottom.equalTo(contentView.snp_bottom).offset(-15)
            make.right.equalTo(contentView).offset(-15)
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        let statusLabel = UILabel()
        statusLabel.font = UIFont.boldSystemFontOfSize(14)
        statusLabel.textColor = themColor
        statusLabel.text = labelString
        statusLabel.textAlignment = .Right
        contentView.addSubview(statusLabel)
        statusLabel.snp_makeConstraints { (make) in
            make.top.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-15)
            make.height.equalTo(30)
           
        }
        
        
    }
    func show()  {
        
    }
    func addMargin() {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: 10))
        view.backgroundColor = bgColor
        contentView.addSubview(view)
    }
    
    func addSepLine(refrenceView: UIView?)  {
        // 添加分割线
        let view = UIView()
        view.backgroundColor = gray
        contentView.addSubview(view)
        view.snp_makeConstraints { (make) in
            make.height.equalTo(1)
            make.top.equalTo(refrenceView!.snp_bottom).offset(10)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView)
        }
        view.transform = CGAffineTransformMakeScale(1, 0.5)
        
        
    }
    func totalPrice(refrenceView: UIView?, totalCount: String) -> UIView{
        let totalView = UIView()
        self.contentView.addSubview(totalView)
        totalView.snp_makeConstraints { (make) in
            make.top.equalTo(refrenceView!.snp_bottom)
            make.width.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
        let label1 = UILabel()
        label1.text = "总计:"
        label1.textAlignment = .Left
        totalView.addSubview(label1)
        label1.snp_makeConstraints { (make) in
            make.top.equalTo(totalView).offset(15)
            make.left.equalTo(totalView).offset(20)
        }
        let label2 = UILabel()
        totalView.addSubview(label2)
        label2.textAlignment = .Left
        label2.textColor = red
        label2.text = model.money
        label2.snp_makeConstraints { (make) in
            make.top.equalTo(totalView).offset(15)
            make.left.equalTo(label1.snp_right).offset(5)
        }
        return label2
    }
    func add ()  {
         // 290.00不能直接转换为整形
                    self.i = self.i + 1
                    self.countLabel?.text = "\(self.i)"
        
                    let price = Double(self.prices)
                    let sum = Double(self.i * Int.init(price))
                    self.howMuch = "¥\(sum)"
                    self.delegate!.changeTotal(self.howMuch,ints: self.i)
    }
    
    func sub()  {
        if(self.i >= 2){
                        self.i = self.i - 1
                        self.countLabel?.text = "\(self.i)"
                        }
                        let price = Double(self.prices)
                        let sum = Double(self.i * Int.init(price))
                        self.howMuch = "¥\(sum)"
                        self.delegate!.changeTotal(self.howMuch ,ints: self.i)
    }
    func count(refrenceView: UIView?, isHiddenAddSub: Bool, totalCount: Int) {
        let view = UIView()
        self.contentView.addSubview(view)
        view.snp_makeConstraints { (make) in
            make.top.equalTo(refrenceView!.snp_bottom)
            make.width.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
        }
       
        let add = UIButton()
        let iconAdd = UIImage(named: "iconfont-jiajiananniu02")
        add.setImage(iconAdd, forState: UIControlState.Normal)
        add.backgroundColor = grayClear
        add.withAction(self, selector: #selector(ShoppingListCell.add))

        view.addSubview(add)
        add.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(-20)
            make.top.equalTo(view).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
       
        let sub = UIButton(type: .Custom)
        let iconSub = UIImage(named: "iconfont-jiajiananniu01")
        sub.setBackgroundImage(iconSub, forState: UIControlState.Normal)
        sub.backgroundColor = grayClear
        view.addSubview(sub)
        sub.snp_makeConstraints { (make) in
            make.right.equalTo(view).offset(-80)
            make.top.equalTo(view).offset(10)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        sub.withAction(self, selector: #selector(ShoppingListCell.sub))

        
        let counts = UILabel()
        view.addSubview(counts)
        counts.text = "购买数量"
        counts.font = labelFont
        counts.snp_makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(10)
        }
        let countlable  = UILabel()
        self.countLabel = countlable
        view.addSubview(countlable)
        countlable.text = "1"
        countlable.textAlignment = .Center
        countlable.snp_makeConstraints { (make) in
            make.right.equalTo(add.snp_left)
            make.left.equalTo(sub.snp_right)
            make.top.equalTo(view).offset(10)
            make.height.equalTo(20)
            
        }
        if isHiddenAddSub {
            add.hidden = true
            sub.hidden = true
            countlable.text = "\(totalCount)"
        }
        
    }
    
    func createStoreName() -> UIView {
        let view = UIView()
        self.contentView.addSubview(view)
        view.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView)
            make.width.equalTo(self.contentView)
            make.height.equalTo(50)
        }
        view.addSubview(nameLabel)
        nameLabel.text = goodNamelabel.text
        nameLabel.font = labelFont
        nameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(18)
            make.top.equalTo(30)
        }
        
        return view
    }
    
    func createDetail(refrenceView: UIView?, bgforeColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = bgforeColor
        self.contentView.addSubview(view)
        view.snp_makeConstraints { (make) in
            make.top.equalTo(refrenceView!.snp_bottom).offset(10)
            make.width.equalTo(self.contentView)
            make.height.equalTo(80 + hhh)
        }
        iconImageView.backgroundColor = white
        view.addSubview(iconImageView)
        iconImageView.snp_makeConstraints { (make) in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(view).offset(10)
            make.bottom.equalTo(view).offset(-10)
            make.width.equalTo(100)
        }
        view.addSubview(goodNamelabel)
        goodNamelabel.snp_makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp_right).offset(20)
            make.top.equalTo(view).offset(20)
        }
        view.addSubview(detailLabel)
        detailLabel.snp_makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp_right).offset(20)
            make.top.equalTo(goodNamelabel.snp_bottom).offset(10)
            make.height.equalTo(hhh)
            make.right.equalTo(view)
        }
        view.addSubview(priceView)
        priceView.textColor = UIColor.redColor()
        priceView.snp_makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp_right).offset(20)
            make.top.equalTo(detailLabel.snp_bottom).offset(10)
        }
        return view
    }
    let iconImageView = UIImageView()
    let priceView = UILabel()
    let detailLabel = UILabel()
    let goodNamelabel = UILabel()
    var hhh = CGFloat()
    
    
    func setData(Model: GoodsModel) {
        priceView.text = "¥ \(Model.price)"
        priceView.font = labelFont
        self.prices = Model.price
       
        
        detailLabel.text = Model.brief
        detailLabel.font = labelFont
        detailLabel.numberOfLines = 0
        detailLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        let constraint = CGSize(width: contentView.frame.width, height: 10000.0)
        
        let size = NSString.init(string: Model.brief).boundingRectWithSize(constraint, options: .UsesLineFragmentOrigin, attributes: NSDictionary(object:UIFont.systemFontOfSize(12), forKey: NSFontAttributeName) as? [String : AnyObject], context: nil)
        hhh = size.height
        
        
        
        goodNamelabel.text = Model.name
        goodNamelabel.font = labelFont
        iconImageView.kf_setImageWithURL(NSURL.init(string: Model.thumb)!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
