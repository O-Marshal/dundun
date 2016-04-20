//
//  WalletViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/16.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import Alamofire

class WalletViewController: BaseViewController {
    
    override func viewDidLoad() {
        
        let btn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50 ))
        addsubView(btn)
        
        btn.backgroundColor = UIColor.redColor()
        
        btn.addTarget(self, action: #selector(load), forControlEvents: .TouchUpInside)
        
    }
    
    func load() {
        LoginController.login(self)
//        print("开始上传")
//        let file = NSBundle.mainBundle().pathForResource("Mog", ofType: "png")
//        let imageData = UIImagePNGRepresentation(UIImage(contentsOfFile: file!)!)
//        
//        
//        Alamofire.upload(.POST, "http://api.laravel.com/user/file", multipartFormData: { (data) in
//            /**
//             *   data: 图片， name: 服务器接收文件的参数名（判断是哪一张图片）, fileName: 服务器获取到图片的名称， mimeType： 文件类型
//             */
//            data.appendBodyPart(data: imageData!, name: "file", fileName: "fileasdsad", mimeType: "image/*")
//            }) { (result) in
//                print("数据准备完成；")
//                switch result {
//                case .Success(let upload, _, _):
////                    case .Success(request: Request, streamingFromDisk: Bool, streamFileURL: NSURL?):
//                    upload.responseString(completionHandler: { (respone) in
//                        print(respone)
//                    })
//                case .Failure(let err):
//                    print(err)
//                    break
//                }
//        }
        
        
        
//        Alamofire.request(.POST, "http://api.laravel.com/user/file", parameters: ["file": UIImage(contentsOfFile: file!)!], encoding: .URL, headers: nil).responseString { (response) in
//            print(response)
//        }
        
    }

}
