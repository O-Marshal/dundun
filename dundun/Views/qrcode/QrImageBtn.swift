//
//  QrImageBtn.swift
//  dundun
//
//  Created by 刘荣 on 16/4/28.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
protocol QrImageBtnProtocol {
    func onChangeEvent(identify: Int)
}

class QrImageBtn: UIView {
    
    let btn = UIButton()
    let imgView = UIImageView()
    
    var identify = 0
    var selected = false
    var delegate: QrImageBtnProtocol?
    
    let imgArray = [
        (normal: "qr_flash_nor", selected: "qr_flash_down"),
        (normal: "qr_photo_nor", selected: "qr_photo_down"),
        (normal: "qr_myqrcode_nor", selected: "qr_myqrcode_down")
    ]
    
    class func imgBtn(identify: Int, delegate: QrImageBtnProtocol) -> QrImageBtn {
        let btn = QrImageBtn()
        btn.imgView.image = UIImage(named: btn.imgArray[identify].normal)
        btn.identify = identify
        btn.delegate = delegate
        return btn
    }
    
    override func didMoveToSuperview() {
        if superview == nil { return }
        snp_makeConstraints { (make) in
            make.width.equalTo(superview!).multipliedBy(1.0/3.0)
            make.height.equalTo(superview!)
        }
        imgView.addTo(superview!).snp_makeConstraints { (make) in
            make.center.equalTo(self)
        }
        btn.addTo(superview!).snp_makeConstraints { (make) in
            make.size.equalTo(imgView)
            make.center.equalTo(self)
        }
        
        btn.addTarget(self, action: #selector(touchEvent), forControlEvents: .TouchUpInside)
        
    }
    
    func touchEvent() {
        print("哈哈哈")
        if identify == 0 {
            selected = !selected
            let img = selected ? imgArray[identify].selected : imgArray[identify].normal
            imgView.image = UIImage(named: img)
        }
        delegate?.onChangeEvent(identify)
    }

}
