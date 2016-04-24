//
//  RankingView.swift
//  mySwift
//
//  Created by students on 16/4/11.
//  Copyright © 2016年 王允顶. All rights reserved.
//

import UIKit

class RankingView: UIView {
    
    var _ranking : Ranking?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = controlColour

        
    }
    
    func setRanking(ranking : Ranking)
    {
        _ranking = ranking
        
        if(ranking.tag == 1)
        {
            self.setImage()
        }
        else
        {
            self.setStar()
        }
    }
    
    //显示星星
    func setStar()
    {

        let upImage = UIImageView()
        let downImage = UIImageView()
        let view = UIView()
        let name = UILabel()
        view.layer.masksToBounds = true
        
        upImage.image = UIImage(named: (_ranking?.upImage)!)
        downImage.image = UIImage(named: (_ranking?.downImage)!)
        name.text = _ranking?.rankSrr
        self.addSubview(downImage)
        
        downImage.snp_makeConstraints { (make) -> Void in
            
            make.bottom.equalTo(self.snp_bottom).offset(-50)
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.centerX.equalTo(self)

        }
        
        var width = Float()
        width = (_ranking?.star)! / 10.0 * 150
        self.addSubview(view)
        view.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(downImage.snp_top)
            make.left.equalTo(downImage.snp_left)
            make.height.equalTo(30)
            make.width.equalTo(width)
        }
        
        view.addSubview(upImage)
        upImage.snp_makeConstraints { (make) -> Void in
            
            make.bottom.equalTo(self.snp_bottom).offset(-50)
            make.width.equalTo(150)
            make.height.equalTo(30)
            make.centerX.equalTo(self)

        }
        
        self.addSubview(name)
        name.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp_top).offset(50)
            make.centerX.equalTo(self)
        }
        
    }
    
    //显示当前排名
    func setImage()
    {
        let imageRad = UIImageView()
        let btn = UIButton(type: UIButtonType.System)
        self.addSubview(btn)
       
        
        self.addSubview(imageRad)
        imageRad.image = UIImage(named: (_ranking?.downImage)!)
        imageRad.snp_makeConstraints { (make) -> Void in
            
            make.top.equalTo(self).offset(20)

            make.centerX.equalTo(self)
            make.width.equalTo(150)
            make.height.equalTo(100)

        }
        
        let text = UILabel()
        text.textColor = UIColor.whiteColor()
        self.addSubview(text)
        text.text = _ranking?.upImage
        text.snp_makeConstraints { (make) -> Void in
            
            make.center.equalTo(imageRad)

        }
        
        let name = UILabel()
        self.addSubview(name)
        name.text = _ranking?.rankSrr
        name.snp_makeConstraints { (make) -> Void in
            
            make.bottom.equalTo(self.snp_bottom).offset(-20)
            make.centerX.equalTo(self)
        }
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
