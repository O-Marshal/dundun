//
//  MScollView.swift
//  dundun
//
//  Created by 刘荣 on 16/4/29.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Kingfisher

class MScollView: UIView {
    
    var datas: [String] = []
    
    let scrollView = UIScrollView()
    let pageController = UIPageControl()
    
    func setData(datas: [String]) {
        self.datas = datas
        if datas.count < 2 { return }
        pageController.numberOfPages = datas.count
        
        /**
         *  添加图片
         */
        for i in 0..<datas.count {
            addsubImage(datas[i], multiplie: (CGFloat(i) + 1.5) * 2)
        }
        // 首图
        addsubImage(datas.last!, multiplie: 1)
        // 尾图
        addsubImage(datas.first!, multiplie: (CGFloat(datas.count) + 1.5) * 2)
        
        scrollView.contentSize = CGSize(width: MSize.defaultSize.width * CGFloat(datas.count + 2), height: 0)
        scrollView.contentOffset.x = MSize.defaultSize.width // 默认偏移一个视图
        
        Timer.every(3, target: self, selector: #selector(everyTimeEvent))
    }
    
    override func didMoveToSuperview() {
        backgroundColor = UIColor.whiteColor()
        if superview == nil { return }
        
        snp_makeConstraints { (make) in
            make.top.equalTo(410)
            make.width.equalTo(superview!)
            make.height.equalTo(150)
        }
        
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.addTo(self).snp_makeConstraints { (make) in
            make.top.left.width.height.equalTo(self)
        }
        
        pageController.addTo(self).snp_makeConstraints { (make) in
            make.centerX.bottom.equalTo(self)
        }
    }
}

extension MScollView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / MSize.defaultSize.width)
        if page == 0 {// 首图前一张 - 变换到最末尾
            pageController.currentPage = datas.count
            scrollView.contentOffset.x = MSize.defaultSize.width * CGFloat(datas.count)
        } else if page == datas.count + 1 {
            pageController.currentPage = 0
            scrollView.contentOffset.x = MSize.defaultSize.width
        } else {
            pageController.currentPage = page - 1
        }
    }
    
    func everyTimeEvent() {
        UIView.animateWithDuration(1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.8, options: [], animations: {
            self.scrollView.contentOffset.x += MSize.defaultSize.width
            }) { (let _) in
                self.scrollViewDidEndDecelerating(self.scrollView)
        }
    }
    
    func addsubImage(url: String, multiplie: CGFloat) {
        let scrollImageView = UIImageView()
        scrollImageView.contentMode = .ScaleAspectFill
        scrollImageView.kf_setImageWithURL(NSURL(string: url)!, placeholderImage: UIImage(named: "icon_imageLoading"), optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        scrollImageView.addTo(scrollView).snp_makeConstraints(closure: { (make) in
            make.top.width.height.equalTo(scrollView)
            make.centerX.equalTo(scrollView).multipliedBy(multiplie)
        })
    }
}