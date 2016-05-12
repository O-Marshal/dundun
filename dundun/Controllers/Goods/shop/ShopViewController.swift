//
//  ShopViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/5/4.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import MapKit
import Kingfisher

class ShopViewController: BaseViewController {
    
    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
    
    var pid = 0
    
    var model: ShopModel = ShopModel()
    
    let backButton = NaviBarBackView.defaultButton()
    
    let scrollImageView = UIImageView()
    let nameView = UILabel()
    let scrollImageViewHeight: CGFloat = 220
    
    var barOffset = false
    
    class func show(viewController: UIViewController, pid: Int = 0) {
        let shop = ShopViewController()
        shop.pid = pid
        viewController.showViewController(shop, sender: nil)
    }
    
    override func initView() {
        title = "商铺详情"
        collectionView.withBack(MColor.backgroundColor).addTo(view).snp_makeConstraints { (make) in
            make.top.bottom.width.equalTo(view)
        }
        initScrollTopView()
    }
    
    override func initEvent() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.registerClass(GoodsCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "goods")
        collectionView.registerClass(NoneCollectionVIewCell.classForCoder(), forCellWithReuseIdentifier: "none")
        collectionView.registerClass(ShopHeaderCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "header")
        
        postWithLogin("http://dundun.mog.name/shop/shop/\(pid)", params: [:])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let jsonDict = MJson.json(result).dictionary {
            model.shopName = jsonDict["shopName"]!.stringValue
            model.locale = jsonDict["locale"]!.stringValue
            model.shopInfo = jsonDict["shopInfo"]!.stringValue
            model.backgroundImage = jsonDict["backgroundImage"]!.stringValue
            model.logo = jsonDict["logo"]!.stringValue
            model.follow = jsonDict["follow"]!.intValue
            model.lat = jsonDict["lat"]!.doubleValue
            model.lon = jsonDict["lon"]!.doubleValue
            
            if let goodsArray = jsonDict["goods"]?.array {
                model.goods += goodsArray.map({ GoodsModel(jsonString: $0.description) })
            }
            setData()
        }
    }
    
    private func setData() {
        title = model.shopName
        nameView.text = model.shopName
        scrollImageView.m_setImage(model.backgroundImage)
        collectionView.reloadData()
    }
    
    // 头部
    func initScrollTopView() {
        scrollImageView.addTo(view).snp_makeConstraints { (make) in
            make.top.equalTo(-20)
            make.width.equalTo(view)
            make.height.equalTo(scrollImageViewHeight)
            make.centerX.equalTo(view)
        }
        nameView.addTo(view).snp_makeConstraints { (make) in
            make.left.equalTo(view).offset(20)
            make.bottom.equalTo(scrollImageView).offset(-10)
        }
        
        scrollImageView.contentMode = .ScaleAspectFill
        scrollImageView.clipsToBounds = true
        nameView.text = "盾盾官方商店"
        nameView.textColor = UIColor.whiteColor()
        nameView.font = UIFont(name: "Heiti SC", size: 22)
        scrollImageView.image = UIImage(named: "icon_imageLoading")
        backButton.withAction(self, selector: #selector(dismissEvent)).addTo(view)
    }
    
}

// MARK: - CollectionView Delegate
extension ShopViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let h = scrollView.contentOffset.y + 20
        if h < scrollImageViewHeight {
            // --------------------- 顶部图片变动 -------------------------
            let changeHeight = max(scrollImageViewHeight - h, 0)
            // 高度变更
            scrollImageView.snp_updateConstraints(closure: { $0.height.equalTo(changeHeight) })
            // 下拉到顶部，图片放大
            if h < 0 { scrollImageView.snp_updateConstraints(closure: { $0.width.equalTo(view).offset(-h) }) }
            
            // --------------------- 导航栏变动 -------------------------
            if barOffset {
                barOffset = !barOffset
                UIView.animateWithDuration(0.6, animations: {
                    self.navigationController?.navigationBarHidden = true
                    self.backButton.hidden = false
                })
            }
        } else {
            // --------------------- 导航栏变动 -------------------------
            if !barOffset {
                barOffset = !barOffset
                UIView.animateWithDuration(0.6, animations: {
                    self.navigationController?.navigationBarHidden = false
                    self.backButton.hidden = true
                })
            }
        }
    }
    
    func barHidenAnimate() {
        if barOffset {
            UIView.animateWithDuration(0.6, animations: {
                self.navigationController?.navigationBarHidden = false
                self.backButton.hidden = true
            })
        } else {
            UIView.animateWithDuration(0.6, animations: {
                self.navigationController?.navigationBarHidden = true
                self.backButton.hidden = false
            })
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            return
        }
        if model.goods.count == 0 {
            return
        }
        let detail = GoodsDetailViewController()
        detail.model = model.goods[indexPath.row]
        showViewController(detail, sender: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return model.goods.count == 0 ? 1 : model.goods.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("header", forIndexPath: indexPath) as! ShopHeaderCollectionViewCell
            cell.setData(pid, model: model)
            cell.delegate = self
            return cell
        }
        if model.goods.count == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("none", forIndexPath: indexPath) as! NoneCollectionVIewCell
            cell.initView("暂时没有推荐商品，请稍后再试")
            return cell
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("goods", forIndexPath: indexPath) as! GoodsCollectionViewCell
        cell.initView(model.goods[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.frame.width, height: 330)
        }
        if model.goods.count == 0 {
            return view.frame.size
        }
        let width = view.frame.width / 2 - 15
        return CGSize(width: width, height: width + 60 )
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if model.goods.count == 0 || section == 0 {
            return UIEdgeInsetsZero
        }
        return UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
    }
}

// MARK: - 回调事件
extension ShopViewController: MButtonEventIdentifyDelegate {
    func onTouchEvent(identify: String?) {
        if identify == "map" {
            let currentLocation = MKMapItem.mapItemForCurrentLocation()
            let tol =   CLLocationCoordinate2D(latitude: model.lat, longitude: model.lon)
            let tolocation = MKMapItem(placemark: MKPlacemark(coordinate: tol, addressDictionary: nil))
            tolocation.name = model.shopName
            MKLaunchOptionsDirectionsModeKey
            MKLaunchOptionsDirectionsModeDriving
            let option = [
                MKLaunchOptionsMapCenterKey: NSValue(MACoordinate: tol),
                MKLaunchOptionsMapSpanKey: NSValue(MKCoordinateSpan: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            ]
            MKMapItem.openMapsWithItems([tolocation,currentLocation],launchOptions: option)
        }
    }
    func onTouchEvent(identify: String?, index: Int) {
        
    }
}


// MARK: - 影藏NavigationBar
extension ShopViewController {
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBarHidden = false
    }
}