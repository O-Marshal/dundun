//
//  GoodsDetailViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/3.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Kingfisher
import Ji
import SwiftyJSON

class GoodsDetailViewController: BaseViewController {
    
    var model = GoodsModel()
    
    let galleryView = GoodsGalleryScrollView()
    let infoVIew = GoodsInfoView()
    let shopView = GoodsShopInfoView()
    
    let scrollWrapView = UIScrollView()
    let scrollTop = UIScrollView()
    let scrollDetail = UIScrollView()
    
    let moreTop = GoodsDetailGetMoreInfoView()
    let moreDetail = GoodsDetailGetMoreInfoView()
    
    let tabView = UIButton()
    
    let defaultHeight: CGFloat = MSize.defaultSize.height - 120
    let defaultRect = CGRect(x: 0, y: 0, width: MSize.defaultSize.width, height: MSize.defaultSize.height - 120)

    
    override func initView() {
        title = model.name
        scrollWrapView.addTo(view).frame = defaultRect
        
        scrollTop.addTo(scrollWrapView).frame = defaultRect
        scrollTop.addSubview(galleryView)
        infoVIew.setTopView(galleryView).setData(model).addTo(scrollTop)
        shopView.setTopView(infoVIew).addTo(scrollTop)
        let topHeight = galleryView.mHeight + infoVIew.mHeight + shopView.mHeight + 30
        scrollTop.contentSize = CGSize(width: 0, height: max(topHeight, defaultHeight + 1))
        
        moreTop.addTo(scrollTop).snp_makeConstraints { (make) in
            make.top.equalTo(shopView.snp_bottom)
        }
        moreDetail.addTo(scrollDetail).snp_makeConstraints { (make) in
            make.top.equalTo(-100)
        }
        
        
        scrollDetail.addTo(scrollWrapView).frame = CGRect(x: 0, y: defaultHeight, width: defaultRect.width, height: defaultHeight)
        initHtmlView()
        
        tabView.withBack(UIColor.whiteColor()).addTo(view).snp_makeConstraints { (make) in
            make.bottom.width.equalTo(view)
            make.height.equalTo(50)
        }
        tabView.withAction(self, selector: #selector(goodsBuy))
        tabView.backgroundColor = MColor.themeColor
        let atrString = NSAttributedString(string: "立即购买", attributes: [NSFontAttributeName: UIFont.systemFontOfSize(20), NSForegroundColorAttributeName: UIColor.whiteColor()])
        tabView.setAttributedTitle(atrString, forState: .Normal)
    }
    
    func goodsBuy() {
        let order = IndentViewController()
        order.model = model
        showViewController(order, sender: nil)
    }
    
    override func initEvent() {
        scrollTop.delegate = self
        scrollDetail.delegate = self
        
        shopView.delegate = self
        
        get("http://dundun.mog.name/shop/info/\(model.pid)")
        
        initScrollView()
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let jsonDict = MJson.json(result).dictionary {
            shopView.setData(jsonDict["name"]!.stringValue, logo: jsonDict["logo"]!.stringValue)
        }
    }
    
    func initScrollView() {
        let html = Ji(htmlString: model.html)
        if let imageArray = html?.xPath("//img") {
            galleryView.setData(imageArray.map({ $0.attributes["src"]! }))
        }
    }
    
    func initHtmlView() {
        let html = Ji(htmlString: model.html)
        if let imageArray = html?.xPath("//img") {
            
            var scrollHeight: CGFloat = 0
            var lastView = scrollDetail.snp_top
            for imageDom in imageArray {
                let imgView = UIImageView()
                imgView.kf_setImageWithURL(NSURL(string: imageDom.attributes["src"]!)!, placeholderImage: UIImage(named: "icon_imageLoading"), optionsInfo: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
                    if let netImage = image {
                        let imgHeight = netImage.size.height * self.view.frame.width / netImage.size.width
                        scrollHeight += imgHeight - 200
                        self.scrollDetail.contentSize = CGSize(width: 0, height: max(scrollHeight, self.scrollDetail.frame.height))
                        imgView.snp_updateConstraints(closure: { (make) in
                            make.height.equalTo(imgHeight)
                        })
                    }
                })
                imgView.addTo(scrollDetail).snp_makeConstraints(closure: { (make) in
                    make.top.equalTo(lastView)
                    make.width.equalTo(scrollDetail)
                    make.height.equalTo(200)
                })
                scrollHeight += 200
                lastView = imgView.snp_bottom
            }
        }
    }
    
}

extension GoodsDetailViewController: UIScrollViewDelegate{
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let th = scrollView.contentOffset.y + defaultHeight - scrollView.contentSize.height
        if scrollView == scrollTop {
            if th > 100 {
                moreTop.setText("松开手跳转到详情页面")
            } else {
                moreTop.setText("上拉查看详请页面")
            }
        } else if scrollView == scrollDetail {
            if scrollView.contentOffset.y < -100 {
                moreDetail.setText("松开手返回到商品页面")
            } else {
                moreDetail.setText("下拉返回商品页面")
            }
        }
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let th = scrollView.contentOffset.y + defaultHeight - scrollView.contentSize.height
        if scrollView == scrollTop {
            if th > 100 {
                UIView.animateWithDuration(1, animations: { 
                    self.scrollWrapView.contentOffset.y = self.defaultHeight
                })
            }
        } else if scrollView == scrollDetail {
            if scrollView.contentOffset.y < -100 {
                UIView.animateWithDuration(1, animations: {
                    self.scrollWrapView.contentOffset.y = 0
                })
            }
        }
    }
}

extension GoodsDetailViewController: MButtonEventIdentifyDelegate {
    func onTouchEvent(identify: String?) {
        if identify == "shop" {
            print(model.pid)
            ShopViewController.show(self, pid: model.pid)
        } else if identify == "part" {
            Notify.show(Whisper: "商家圈子尚未开通，敬请期待", theme: NotiTheme.Warring, viewController: self)
        }
    }
    func onTouchEvent(identify: String?, index: Int) {
        
    }
}
