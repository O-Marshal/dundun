//
//  ShopHeaderCollectionViewCell.swift
//  dundun
//
//  Created by 刘荣 on 16/5/5.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ShopHeaderCollectionViewCell: UICollectionViewCell {
    
    var delegate: MButtonEventIdentifyDelegate?
    
    var model = ShopModel()
    
    // 地址
    let wrapView = UIView()
    let collectionView = ShopCollectionView()
    
    let labAdr = ShopHeaderLabelView()
    let labOther = ShopHeaderLabelView()
    
    // 商品列表
    let labView = UILabel()
    
    private var shopID = 0
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.bottom.equalTo(self)
        }
        // 地址等信息
        wrapView.addTo(self).snp_makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(100)
            make.bottom.equalTo(labView.snp_top).offset(-10)
        }
        
        collectionView.addTo(wrapView)
        labAdr.addTo(wrapView).snp_makeConstraints { (make) in
            make.top.left.equalTo(wrapView)
            make.right.equalTo(collectionView.snp_left)
        }
        labOther.addTo(wrapView).snp_makeConstraints { (make) in
            make.top.equalTo(wrapView).offset(40)
            make.left.right.equalTo(labAdr)
        }
    }
    
    private func initView() {
        backgroundColor = UIColor.clearColor()
        wrapView.backgroundColor = UIColor.whiteColor()
        
        labView.text = "商品列表"
        labView.textColor = MColor.textHeaderColor
        labView.font = UIFont(name: "Heiti SC", size: 18)
        
        labAdr.setLab("shop_local", lab: "地址：")
        labOther.setLab("shop_menu", lab: "主营：")

        labAdr.infoVIew.addTapEvent(self, action: #selector(touchEvent))
    }
    
    func touchEvent() {
        delegate?.onTouchEvent("map")
    }
    
    func setData(id: Int, model: ShopModel) {
        shopID = id
        self.model = model
        labAdr.setInfo(model.locale)
        labOther.setInfo(model.shopInfo)
        collectionView.setData(id, col: model.follow == 1)
    }

}

/// 子视图
class ShopHeaderLabelView: UIView {
    
    let imgView = UIImageView()
    let labView = UILabel()
    let infoVIew = UILabel()
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.height.equalTo(50)
        }
        imgView.addTo(self).snp_makeConstraints { (make) in
            make.top.left.equalTo(15)
            make.width.height.equalTo(25)
        }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(imgView)
            make.width.equalTo(55)
            make.left.equalTo(imgView.snp_right).offset(5)
        }
        infoVIew.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(imgView)
            make.left.equalTo(labView.snp_right).offset(5)
            make.right.equalTo(self).offset(-20)
        }
    }
    
    func setLab(icon: String, lab: String) {
        imgView.image = UIImage(named: icon)
        labView.text = lab
    }
    
    func setInfo(info: String) {
        infoVIew.text = info
    }
    
    private func initView() {
        labView.textColor = MColor.textHeaderColor
        infoVIew.textColor = MColor.textPlacholderColor
        labView.font = UIFont(name: "Heiti SC", size: 18)
        infoVIew.font = UIFont(name: "Heiti SC", size: 18)
    }
}



/// 收藏视图
class ShopCollectionView: UIView {
    
    var pid = 0
    
    let imgView = UIImageView()
    let labView = UILabel()
    
    private var collect = false
    
    override func didMoveToSuperview() {
        initView()
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.height.width.equalTo(80)
            make.right.centerY.equalTo(superview!)
        }
        imgView.addTo(self).snp_makeConstraints { (make) in
            make.centerY.equalTo(self).offset(-10)
            make.centerX.equalTo(self)
            make.width.height.equalTo(30)
        }
        labView.addTo(self).snp_makeConstraints { (make) in
            make.top.equalTo(imgView.snp_bottom).offset(5)
            make.centerX.equalTo(self)
        }
        
        let line = UIView().withBack(MColor.lineDefaultColor).addTo(self)
        line.snp_makeConstraints { (make) in
            make.left.centerY.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.8)
            make.width.equalTo(MSize.defaultSize.px(1))
        }
    }
    
    private func initView() {
        touchChange()
        labView.textColor = MColor.textLabelColor
        labView.font = UIFont(name: "Heiti SC", size: 16)
        
        imgView.addTapEvent(self, action: #selector(touchEvent))
    }
    
    func touchEvent() {
        let url = collect ? "http://dundun.mog.name/shop/decollection" : "http://dundun.mog.name/shop/collection"
        let params = [
            "uid": LoginController.userInfo()["userID"]!,
            "sid": pid
        ]
        let request = Alamofire.request(.POST, url, parameters: params, encoding: ParameterEncoding.URL, headers: nil)
        request.responseString {
            if let data = $0.data {
                if JSON(data: data)["errCode"].intValue == 1 {
                    self.collect = !self.collect
                    self.touchChange()
                    return
                }
            }
        }
    }
    
    func setData(pid: Int, col: Bool) {
        self.pid = pid
        collect = col
        touchChange()
    }
    
    private func touchChange() {
        if collect {
            imgView.image = UIImage(named: "shop_collect_ed")
            labView.text = "已收藏"
        } else {
            imgView.image = UIImage(named: "shop_collect")
            labView.text = "收藏"
        }
    }
}
