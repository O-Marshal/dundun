//
//  ExtensionKingfisher.swift
//  dundun
//
//  Created by 刘荣 on 16/5/5.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func m_setImage(url: String) {
        let placeholderImage = UIImage(named: "icon_imageLoading")
        if let nsurl = NSURL(string: url) {
            kf_setImageWithURL(nsurl, placeholderImage: placeholderImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        } else {
            image = placeholderImage
        }
    }
    
}
