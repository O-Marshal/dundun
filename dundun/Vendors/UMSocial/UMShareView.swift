//
//  UMShareView.swift
//  dundun
//
//  Created by 刘荣 on 16/5/7.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SnapKit

class UMShareView: UIView {
    
    static var defaultView: UMShareView {
        let view = UMShareView()
        view.initView()
        return view
    }
    
    typealias shareSize = (x: Float, y: Float)
    typealias sharesType = (view: UMShareViewLab, identify: String, img: String, lab: String)
    let items: [sharesType] = [
        (UMShareViewLab(), UMShareToQQ, "share_qq", "QQ"),
        (UMShareViewLab(), UMShareToQzone, "share_qzone", "空间"),
        (UMShareViewLab(), UMShareToSina, "share_sinaweibo", "微博"),
        (UMShareViewLab(), UMShareToWechatSession, "share_wechat", "微信"),
        (UMShareViewLab(), UMShareToWechatTimeline, "share_wechatfavorite", "收藏"),
        (UMShareViewLab(), UMShareToWechatFavorite, "share_wechatmoments", "朋友圈")
    ]
    
    let wrapView = UIView()
    
    private func initView() {
        frame = MSize.defaultSize.frame
        backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        wrapView.backgroundColor = UIColor.whiteColor()
        
        wrapView.addTo(self).snp_makeConstraints { (make) in
            make.height.equalTo(0)
            make.width.bottom.equalTo(self)
        }
        
        let labView = UILabel()
        labView.text = "分享到"
        labView.textColor = MColor.textLabelColor
        labView.font = UIFont.systemFontOfSize(16)
        labView.addTo(wrapView).snp_makeConstraints { (make) in
            make.centerX.equalTo(wrapView)
            make.top.equalTo(wrapView).offset(15)
        }
        
        let lineView = UIView()
        lineView.withBack(MColor.lineUserInfoColor).addTo(wrapView).snp_makeConstraints { (make) in
            make.top.equalTo(labView.snp_bottom).offset(15)
            make.left.right.equalTo(self)
            make.height.equalTo(MSize.defaultSize.px(1))
        }
        
        let leftSpace = MSize.defaultSize.width / 5 - 40
        var left = leftSpace
        var top = 80
        
        var tag = 0
        for item in items {
            item.view.tag = tag
            item.view.withAction(self, selector: #selector(touchEvent))
            item.view.initView(item.lab, img: item.img)
            item.view.addTo(self).snp_makeConstraints(closure: { (make) in
                make.left.equalTo(left)
                make.top.equalTo(wrapView.snp_top).offset(top)
            })
            left += leftSpace + 50
            if left + leftSpace + 50  > MSize.defaultSize.width {
                left = leftSpace
                top += 80
            }
            tag += 1
        }
        
        layoutIfNeeded()
    }
    
    var viewController: UIViewController?
    var title = "盾盾"
    var shareText = "分享内容"
    var shareImage = UIImage(named: "icon_logo")
    var shareUrl = "http://bill.microali.cn/down/"
    
    func setVC(vc: UIViewController) {
        viewController = vc
    }
    
    func shareWeb(vc: UIViewController, tit: String, text: String, img: String, url: String) {
        viewController = vc
        title = tit
        shareText = text
        shareImage = UIImage(named: img)
        shareUrl = url
    }
    
    func touchEvent(sender: UIButton) {
        switch sender.tag {
        case 0 :
            shareQQ()
        case 1:
            shareQzone()
        case 2:
            shareSina()
        case 3:
            shareWeiXin()
        case 4:
            shareWeiXinFavorite()
        case 5:
            shareWeiXinTimeline()
        default:
            break
        }
        missEvent()
    }
    
    
    
    func show() {
        UIApplication.sharedApplication().keyWindow?.addSubview(self)
    }
    
    override func didMoveToSuperview() {
        setNeedsLayout()
        wrapView.snp_updateConstraints { (make) in
            make.height.equalTo(250)
        }
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
            }, completion: nil)

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        missEvent()
    }
    
    func missEvent() {
        wrapView.setNeedsLayout()
        wrapView.snp_updateConstraints { (make) in
            make.height.equalTo(0)
        }
        UIView.animateWithDuration(0.6, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.wrapView.layoutIfNeeded()
            self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }) { (comp) in
            self.removeFromSuperview()
        }
    }
}

// MARK: - 分享
extension UMShareView {
    func shareWeiXin() {
        UMSocialData.defaultData().extConfig.wxMessageType = UMSocialWXMessageTypeWeb
        UMSocialData.defaultData().extConfig.wechatSessionData.title = title
        UMSocialData.defaultData().extConfig.wechatSessionData.url = shareUrl
        UMSocialData.defaultData().extConfig.wechatSessionData.shareImage = shareImage
        UMSocialData.defaultData().extConfig.wechatSessionData.shareText = shareText
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession], content: "", image: nil, location: nil, urlResource: nil, presentedController: viewController) { (respone) in
            print(respone)
        }
    }
    
    func shareWeiXinTimeline() {
        UMSocialData.defaultData().extConfig.wxMessageType = UMSocialWXMessageTypeWeb
        UMSocialData.defaultData().extConfig.wechatTimelineData.title = title
        UMSocialData.defaultData().extConfig.wechatTimelineData.url = shareUrl
        UMSocialData.defaultData().extConfig.wechatTimelineData.shareImage = shareImage
        UMSocialData.defaultData().extConfig.wechatTimelineData.shareText = shareText
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatTimeline], content: "", image: nil, location: nil, urlResource: nil, presentedController: viewController) { (respone) in
            print(respone)
        }
    }
    
    func shareWeiXinFavorite() {
        UMSocialData.defaultData().extConfig.wxMessageType = UMSocialWXMessageTypeWeb
        UMSocialData.defaultData().extConfig.wechatFavoriteData.title = title
        UMSocialData.defaultData().extConfig.wechatFavoriteData.url = shareUrl
        UMSocialData.defaultData().extConfig.wechatFavoriteData.shareImage = shareImage
        UMSocialData.defaultData().extConfig.wechatFavoriteData.shareText = shareText
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatFavorite], content: "", image: nil, location: nil, urlResource: nil, presentedController: viewController) { (respone) in
            print(respone)
        }
    }
    
    func shareSina() {
        let resource = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeWeb, url: shareUrl)
        UMSocialData.defaultData().extConfig.sinaData.shareImage = shareImage
        UMSocialData.defaultData().extConfig.sinaData.shareText = shareText
        UMSocialData.defaultData().extConfig.sinaData.urlResource = resource
        UMSocialData.defaultData().extConfig.title = title
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToSina], content: "", image: nil, location: nil, urlResource: nil, presentedController: viewController) { (respone) in
            print(respone)
        }
    }
    
    func shareQQ() {
        UMSocialData.defaultData().extConfig.qqData.shareImage = shareImage
        UMSocialData.defaultData().extConfig.qqData.shareText = shareText
        UMSocialData.defaultData().extConfig.qqData.url = shareUrl
        UMSocialData.defaultData().extConfig.title = title
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToQQ], content: "", image: shareImage, location: nil, urlResource: nil, presentedController: viewController) { (respone) in
            print(respone)
        }
    }
    
    func shareQzone() {
        UMSocialData.defaultData().extConfig.qzoneData.shareText = shareText
        UMSocialData.defaultData().extConfig.qzoneData.url = shareUrl
        UMSocialData.defaultData().extConfig.title = title
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToQzone], content: "", image: shareImage, location: nil, urlResource: nil, presentedController: viewController) { (respone) in
            print(respone)
        }
    }
}

class UMShareViewLab: UIButton {
    let imgView = UIImageView()
    let labView = UILabel()
    
    func initView(lab: String ,img: String) {
        labView.text = lab
        imgView.image = UIImage(named: img)
        
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: 12)
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.width.equalTo(50)
            make.height.equalTo(70)
        }
        imgView.addTo(self).snp_makeConstraints { (make) in
            make.top.left.width.equalTo(self)
            make.height.equalTo(self.snp_width)
        }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.bottom.centerX.equalTo(self)
        }
    }
}
