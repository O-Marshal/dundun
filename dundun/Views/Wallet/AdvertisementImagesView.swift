//
//  AdvertisementImagesView.swift
//  dundun
//
//  Created by wangyongxuan on 16/4/12.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Kingfisher

class AdvertisementImagesView: UIView, UIScrollViewDelegate{
    
    var images:[String]?
    let pageControl = UIPageControl()
    let scrollerView = UIScrollView()
    var timer:NSTimer?
    let width = UIScreen.mainScreen().bounds.size.width
    init(images:[String]){
        super.init(frame:CGRect())
        self.images = images
        scrollerView.pagingEnabled = true
        scrollerView.showsHorizontalScrollIndicator = false
        //scrollerView.contentSize = CGSizeMake(width * CGFloat((images.count)), 0)
        scrollerView.delegate = self
        self.addSubview(scrollerView)
        //pageControl.numberOfPages = images.count
        pageControl.currentPageIndicatorTintColor = UIColor.blueColor()
        self.addSubview(pageControl)
        //addScrollTimer()
    }
    //设置图片
    func setImageList(images:[String]){
    
        self.images = images
        scrollerView.contentSize = CGSizeMake(width * CGFloat((images.count)), 0)
        pageControl.numberOfPages = images.count
        createAdvertisement()
        addScrollTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK scrollerView代理
    func scrollViewDidScroll(scrollView: UIScrollView) {
     
       let page = (scrollView.contentOffset.x + scrollView.frame.size.width / 2) / scrollView.frame.size.width
        pageControl.currentPage = Int.init(page)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.timer?.invalidate()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        addScrollTimer()
    }
    //定时器
    func addScrollTimer(){
       let timer = NSTimer(timeInterval: 2.0, target: self, selector: #selector(AdvertisementImagesView.nextImage), userInfo: nil, repeats: true)
    
       self.timer = timer;
       //消息循环
       NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    
    }
    func nextImage(){
    //当前页码
        var page = self.pageControl.currentPage;
    
        if page == (self.pageControl.numberOfPages - 1) {
            page = 0
        }else{
           page += 1
        }
       let offsetX = CGFloat.init(page) * width
       UIView.animateWithDuration(1.0) { () -> Void in
        self.scrollerView.contentOffset = CGPointMake(offsetX, 0)
        }
    
    }
    
    func createAdvertisement(){
        var views:[UIImageView] = []
        scrollerView.snp_makeConstraints(closure: { (make) -> Void in
            make.top.equalTo(self.snp_top)
            make.left.equalTo(self.snp_left)
            make.width.equalTo(self)
            make.height.equalTo(self)
        })
        for var i=0; i<images?.count; i += 1 {
            //let imageView = UIImageView(image: UIImage(named: images![i]))
            //从网络获取图片
            let imageview = UIImageView()
            imageview.kf_setImageWithURL(NSURL(string: images![i])!)
            scrollerView.addSubview(imageview)
            views.append(imageview)
            //布局
            imageview.snp_makeConstraints { (make) -> Void in
                make.top.equalTo(scrollerView.snp_top)
                make.left.equalTo(i==0 ? scrollerView.snp_left : views[i-1].snp_right)
                make.width.equalTo(self)
                make.height.equalTo(self)
            }
         }
        pageControl.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp_bottom).offset(-10)
            make.centerX.equalTo(self.snp_centerX)
            make.width.equalTo(50)
            make.height.equalTo(20)
        }
   }
}
