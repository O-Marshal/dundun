//
//  HomePageView.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/10.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit

protocol HomePageViewDlegate{
    /**Button代理 */
    func homePageViewDidWithdrawal()
    func homePageViewDidRecharge()
    func homePageViewDidCard()
    func homePageViewDidCashback()
    func homePageViewDidObvious()
    func homePageViewDidScan()
}

class HomePageView: UIView {
    /**扫一扫、提现、充值功能键 */
    var funtionView: UIView?
    /**可用余额*/
    var balanceView: UIView?
    /**资产分析*/
    var assetsView:AssetsView?
    /**卡券*/
    var cardView:UIView?
    /**广告*/
    var imagesView:AdvertisementImagesView?
    /**账户明细*/
    var obviousView:UIView?
    /**分割线颜色*/
    let lineColor = UIColor(red: 0.93, green: 0.95, blue: 1.00, alpha: 1.00)
    let vLineColor = UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1.0)
    var delegate:HomePageViewDlegate?
    //数据
    
    init(frame: CGRect, superView: UIView) {
        super.init(frame: frame)
        //创建视图
        setFunctionView()
        setBalanceView()
        setAssetsView()
        setCardView()
        setImagesView()
        setObviousView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func didMoveToSuperview(){
        //自动布局
        subViewsLayout(funtionView!, topView: self, multipliby: 1/9)
        subViewsLayout(balanceView!, topView: funtionView!, multipliby: 1/9)
        subViewsLayout(assetsView!, topView: balanceView!, multipliby: 3/9)
        subViewsLayout(cardView!, topView: assetsView!, multipliby: 1/9)
        subViewsLayout(imagesView!, topView: cardView!, multipliby: 2/9)
        subViewsLayout(obviousView!, topView: imagesView!, multipliby: 1/9)
    }
    /**子视图布局:subview要布局的视图，topView：要布局的参照视图，multi：与父视图的高比率*/
    func subViewsLayout(subview:UIView, topView:UIView, multipliby:CGFloat){
        subview.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(topView==self ? self.snp_top : topView.snp_bottom)
            make.left.equalTo(self)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(self).multipliedBy(multipliby)
        }
    }
    //创建functionView视图
    func setFunctionView(){
        let funtionView = UIView()
        funtionView.backgroundColor = UIColor(red: 0.38, green: 0.58, blue: 0.98, alpha: 1.0)
        //扫一扫
        let scanbtn = MButton.defaultButton("扫一扫", image: "cardvolume_saoyisao", action: #selector(HomePageView.homePageViewDidScan), target: self)
        scanbtn.tag = 101
        funtionView.addSubview(scanbtn)
        //提现
        let withdrawalbtn = MButton.defaultButton("提现", image: "cardvolume_withdrawalbtn", action: #selector(HomePageView.homePageViewDidWithdrawalbtn), target: self)
        withdrawalbtn.tag = 102
        funtionView.addSubview(withdrawalbtn)
        //充值
        let rechargebrn = MButton.defaultButton("充值", image: "cardvolume_rechargebrn", action: #selector(HomePageView.homePageViewDidRecharge), target: self)
        rechargebrn.tag = 103
        funtionView.addSubview(rechargebrn)
        
        self.addSubview(funtionView)
        self.funtionView = funtionView
        //布局
        let btnW:CGFloat = 50
        let margin:CGFloat = (self.frame.size.width - 3 * btnW) / 6
        for var i = 101; i < 104; i=i+1 {
            let btn = funtionView.viewWithTag(i) as! MButton
            let X:CGFloat = margin + CGFloat.init(i - 101) * (margin * 2 + btnW )
            btn.frame = CGRectMake(X, 0, 60, 60)
            btn.initBack({ () -> Void in
                btn.verticallayout()
                btn.center = CGPoint(x: btn.center.x, y: funtionView.frame.size.height/2)
            })
        }
    }
    //创建balanceView
    func setBalanceView(){
        let balanceView = UIView()
        balanceView.backgroundColor = UIColor.whiteColor()
        let title = UILabel()
        title.text = "可用余额"
        title.tag = 101
        title.font = UIFont.systemFontOfSize(14)
        title.textColor = UIColor.grayColor()
        title.textAlignment = NSTextAlignment.Center
        balanceView.addSubview(title)
        let balance = UILabel()
        balance.text = "0"
        balance.textColor = UIColor(red: 0.96, green: 0.44, blue: 0.43, alpha: 1.0)
        balance.font = UIFont.systemFontOfSize(18)
        balance.textAlignment = NSTextAlignment.Center
        balance.tag = 102
        balanceView.addSubview(balance)
        cellLine(balanceView, tag: 103, height: 10, color: lineColor)
        self.addSubview(balanceView)
        self.balanceView = balanceView
        balanceViewSubViewsLayout()
    }
    //setupBalanceView子视图布局
    func balanceViewSubViewsLayout(){
        let title = balanceView?.viewWithTag(101) as! UILabel
        title.snp_makeConstraints { (make) -> Void in
            make.top.equalTo((balanceView?.snp_top)!).offset(8)
            make.centerX.equalTo((balanceView?.snp_centerX)!)
            make.width.equalTo(80)
            make.height.equalTo(8)
        }
        let balance = balanceView?.viewWithTag(102) as! UILabel
        balance.snp_makeConstraints { (make) -> Void in
            make.top.equalTo((title.snp_bottom)).offset(6)
            make.centerX.equalTo((balanceView?.snp_centerX)!)
            make.width.equalTo(150)
            make.height.equalTo(18)
        }
    }
    //资产
    func setAssetsView(){
      let assetsView = AssetsView()
      assetsView.backgroundColor = UIColor.whiteColor()
      self.assetsView = assetsView
      self.addSubview(assetsView)
     //创建子视图
      assetsView.createView()
    }
    //卡卷
    func setCardView(){
        let cardView = UIView()
        let card = MButton.defaultButton("盾盾卡券", image: "cardvolume_kaquan", action: #selector(HomePageView.homePageViewDidCard), target: self)
        card.tag = 101
        card.setTitleColor(UIColor.blackColor(), forState: .Normal)
        card.horizontalSpacelayout(20)
        cardView.addSubview(card)
        //竖线
        let vLine = UIView()
        cardView.addSubview(vLine)
        vLine.backgroundColor = vLineColor
        vLine.tag = 102
        let cashback = MButton.defaultButton("我的返现", image: "cardvolume_cashbackbtn", action: #selector(HomePageView.homePageViewDidCashback), target: self)
        cashback.tag = 103
        cashback.setTitleColor(UIColor.blackColor(), forState: .Normal)
        cashback.horizontalSpacelayout(20)
        cardView.addSubview(cashback)
        //分割线
        cellLine(cardView, tag: 104, height: 10, color: lineColor)
        self.addSubview(cardView)
        self.cardView = cardView
        cardViewSubViewsLayout()
    }
    
    func cardViewSubViewsLayout(){
        let line = cardView?.viewWithTag(104)
        let card = cardView?.viewWithTag(101)
        card?.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cardView!).offset(10)
            make.left.equalTo(cardView!).offset(-10)
            make.bottom.equalTo((line?.snp_top)!).offset(-10)
        }
        let vLine = cardView?.viewWithTag(102)
        vLine?.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(cardView!)
            make.bottom.equalTo((line?.snp_top)!)
            make.left.equalTo(card!.snp_right)
            make.width.equalTo(2)
        }
        let cashback = cardView?.viewWithTag(103)
        cashback?.snp_makeConstraints { (make) -> Void in
            make.top.right.equalTo(cardView!).offset(10)
            make.bottom.equalTo((line?.snp_top)!).offset(-10)
            make.left.equalTo(vLine!.snp_right)
            make.width.equalTo(card!)
        }
    }
    //广告栏
    func setImagesView(){
        let images:[String] = []
        let imagesView = AdvertisementImagesView(images: images);
        self.addSubview(imagesView)
        self.imagesView = imagesView
        imagesViewSubViewLayout()
    }
    
    func imagesViewSubViewLayout(){
      imagesView?.createAdvertisement()
      cellLine(imagesView!, tag: 101, height: 10, color: lineColor)
    }
    
    //账单明细
    func setObviousView(){
        let obviousView = UIView()
        let obviousbtn = MButton.defaultButton("账单明细", image: "cardvolume_obviousbtn", action: #selector(HomePageView.homePageViewDidObvious), target: self)
        obviousbtn.tag = 101
        obviousbtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        obviousView.addSubview(obviousbtn)
        cellLine(obviousView, tag: 102, height:10 ,color: lineColor)
        self.addSubview(obviousView)
        self.obviousView = obviousView
        obviousViewSubViewLayout()
    }
    
    func obviousViewSubViewLayout(){
        let line = obviousView?.viewWithTag(102)
        let btn = obviousView?.viewWithTag(101) as! MButton
        btn.snp_makeConstraints { (make) -> Void in
            make.top.equalTo((obviousView?.snp_top)!)
            make.bottom.equalTo((line?.snp_top)!)
            make.left.right.equalTo(obviousView!)
        }
       btn.initBack { () -> Void in
          btn.horizontalRightlayout()
        }
    }
    
    //setData
    func setAdvertisemImageNames(data:AdvertisemImageNameModel){
        imagesView?.setImageList(data.advertisemImageNames)
    }
    func setWalleHometData(data:WalletHomeModel){
         assetsView?.setWalletHomeData(data)
         (balanceView?.viewWithTag(102) as! UILabel).text = String( data.m )
    }
    
    //MARK 按钮事件
    func homePageViewDidScan(){
       delegate?.homePageViewDidScan()
    }
    func homePageViewDidWithdrawalbtn(){
        delegate?.homePageViewDidWithdrawal()
    }
    func homePageViewDidRecharge(){
        delegate?.homePageViewDidRecharge()
    }
    func homePageViewDidCard(){
        delegate?.homePageViewDidCard()
    }
    func homePageViewDidCashback(){
        delegate?.homePageViewDidCashback()
    }
    func homePageViewDidObvious(){
        delegate?.homePageViewDidObvious()
    }
}
