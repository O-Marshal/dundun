//
//  GoodsViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import SwiftyJSON
import DGElasticPullToRefresh

class GoodsViewController: BaseViewController {
    
    let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
    
    var datas: [GoodsModel] = []
    
    override func initView() {
        collectionView.withBack(MColor.backgroundColor).addTo(view).frame = view.frame
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        collectionView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self?.get("http://dundun.mog.name/goods/hots")
            self?.collectionView.dg_stopLoading()
            }, loadingView: loadingView)
        collectionView.dg_setPullToRefreshFillColor(MColor.themeColor)
        collectionView.dg_setPullToRefreshBackgroundColor(MColor.backgroundColor)
        
    }
    
    deinit {
        collectionView.dg_removePullToRefresh()
    }
    
    override func initEvent() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = true
        collectionView.registerClass(GoodsCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "goods")
        collectionView.registerClass(NoneCollectionVIewCell.classForCoder(), forCellWithReuseIdentifier: "none")
        
        get("http://dundun.mog.name/goods/hots")
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let jsonArray = MJson.json(result).array {
            datas = jsonArray.map({ GoodsModel(jsonString: $0.description) })
            collectionView.reloadData()
        }
    }

}

extension GoodsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if datas.count == 0 {
            return
        }
        let detail = GoodsDetailViewController()
        detail.model = datas[indexPath.row]
        showViewController(detail, sender: nil)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count == 0 ? 1 : datas.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if datas.count == 0 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("none", forIndexPath: indexPath) as! NoneCollectionVIewCell
            cell.initView("暂时没有推荐商品，请稍后再试")
            return cell
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("goods", forIndexPath: indexPath) as! GoodsCollectionViewCell
        cell.initView(datas[indexPath.row])
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if datas.count == 0 {
            return view.frame.size
        }
        let width = view.frame.width / 2 - 15
        return CGSize(width: width, height: width + 60 )
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        if datas.count == 0 {
            return UIEdgeInsetsZero
        }
        return UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    }
}