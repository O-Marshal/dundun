//
//  QRCodeViewController.swift
//  dundun
//
//  Created by 刘荣 on 16/4/19.
//  Copyright © 2016年 Microali. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit
import SwiftyJSON

class QRCodeViewController: BaseViewController,AVCaptureMetadataOutputObjectsDelegate {
    
    var device:AVCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
    var input:AVCaptureDeviceInput?
    var output:AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    var session:AVCaptureSession = AVCaptureSession()
    var preview:AVCaptureVideoPreviewLayer?
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    let line = UIImageView()
    let boxView = UIView()
    
    let backButton = NaviBarBackView.defaultButton()
    let titleView = NaviBarTitleView.defaultView("扫码/二维码")
    
    let lightButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch let error as NSError {
            print("error:\(error)\n")
        }
        
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        session.sessionPreset = AVCaptureSessionPresetHigh
        if(session.canAddInput(input!)){
            session.addInput(input)
        }
        if(session.canAddOutput(output)){
            session.addOutput(output)
        }
        // 条码类型 AVMetadataObjectTypeQRCode
        output.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        //扫码区域
        initBoxView()
        initView()
        
        preview = AVCaptureVideoPreviewLayer(session: self.session)
        preview!.frame = view.frame
        view.layer.insertSublayer(preview!, atIndex: 0)
        
        backButton.withAction(self, selector: #selector(dismissEvent)).addTo(view)
        titleView.addTo(view)
    }
    
    func initBoxView() {
        let wrapView = QRCodeWrapView().addTo(view)
        wrapView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
        wrapView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        
        boxView.addTo(view).frame = CGRect(x: view.frame.width / 2 - 125, y: 150, width: 250, height: 250)
        boxView.clipsToBounds = true
        
        
        boxView.backgroundColor = UIColor(white: 0, alpha: 0)
        let lt = UIImageView(image: UIImage(named: "qr_left_top")).addTo(view)
        let lb = UIImageView(image: UIImage(named: "qr_left_bot")).addTo(view)
        let rt = UIImageView(image: UIImage(named: "qr_right_top")).addTo(view)
        let rb = UIImageView(image: UIImage(named: "qr_right_bot")).addTo(view)
        let offset = 5
        lt.snp_makeConstraints { (make) in
            make.left.top.equalTo(boxView).offset(-offset)
        }
        lb.snp_makeConstraints { (make) in
            make.left.equalTo(boxView).offset(-offset)
            make.bottom.equalTo(boxView).offset(offset)
        }
        rt.snp_makeConstraints { (make) in
            make.top.equalTo(boxView).offset(-offset)
            make.right.equalTo(boxView).offset(offset)
        }
        rb.snp_makeConstraints { (make) in
            make.right.bottom.equalTo(boxView).offset(offset)
        }
        
        lineLayer.frame = CGRect(x: 0, y: 130, width: 250, height: 120)
        lineLayer.contents = UIImage(named: "qr_net")?.CGImage
        boxView.layer.addSublayer(lineLayer)
        
        lightButton.setTitle("闪光灯：点开", forState: .Normal)
        lightButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        lightButton.withAction(self, selector: #selector(lightEvent))
        lightButton.addTo(wrapView).snp_makeConstraints { (make) in
            make.top.equalTo(boxView.snp_bottom).offset(50)
            make.centerX.equalTo(wrapView)
        }
        
        let infoText = UILabel()
        infoText.numberOfLines = 0
        infoText.addTo(wrapView).snp_makeConstraints { (make) in
            make.left.equalTo(wrapView).offset(30)
            make.right.equalTo(wrapView).offset(-30)
            make.top.equalTo(lightButton.snp_bottom).offset(10)
        }
        infoText.textAlignment = .Center
        infoText.textColor = MColor.lineUserInfoColor
        infoText.text = "当前只能识别盾盾卡卷以及盾盾商家二维码，其他二维码信息无法识别"
    }
    
    let lineLayer = CALayer()
    
    func start() {
        self.session.startRunning()
        if lineLayer.animationForKey("origin.y") == nil {
            let animate1 = CAKeyframeAnimation(keyPath: "position")
            let val0 = NSValue(CGPoint: CGPoint(x: lineLayer.position.x, y: -120))
            let val1 = NSValue(CGPoint: CGPoint(x: lineLayer.position.x, y: 250))
            animate1.autoreverses = false
            animate1.fillMode = kCAFillModeForwards
            animate1.repeatCount = MAXFLOAT
            animate1.duration = 1
            animate1.values = [val0, val1]
            lineLayer.addAnimation(animate1, forKey: "origin.y")
        }
        let pausedTime = lineLayer.timeOffset
        lineLayer.speed = 1
        lineLayer.timeOffset = 0
        lineLayer.beginTime = 0
        let timePause = lineLayer.convertTime(CACurrentMediaTime(), toLayer: nil) - pausedTime
        lineLayer.beginTime = timePause
    }
    
    func stop() {
        self.session.stopRunning()
        let pausedTime = lineLayer.convertTime(CACurrentMediaTime(), toLayer: nil)
        lineLayer.speed = 0
        lineLayer.timeOffset = pausedTime
    }
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        stop()
        if(metadataObjects == nil || metadataObjects.count == 0){ return }
        let mobj = metadataObjects[0].stringValue!
        postWithLogin("http://dundun.mog.name/card/qrcode", params: ["code": mobj])
    }
    
    override func netSuccess(result: String, identifier: String?) {
        if let jsonDict = MJson.json(result).dictionary {
            switch jsonDict["type"]?.stringValue ?? "" {
            case "shop":
                ShopViewController.show(self, pid: jsonDict["id"]?.intValue ?? 0)
            case "card":
                WalletCardInfoViewController.show(self, cardInfo: jsonDict["id"]?.stringValue ?? "0")
            default:
                sleep(1)
                Notify.show(Murmur: "当前二维码信息不能识别", theme: NotiTheme.Warring)
                self.start()
            }
        }
    }
    
    
    func lightEvent(sender: UIButton) {
        sender.setTitle(device.torchMode == .Off ? "闪光灯：关掉" : "闪光灯：点开", forState: .Normal)
        try! device.lockForConfiguration()
        device.torchMode = device.torchMode == .Off ? .On : .Off
        device.unlockForConfiguration()
    }
}


// MARK: - 导航栏隐藏 -- 显示处理
extension QRCodeViewController {
    override func viewDidAppear(animated: Bool) {
        start()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        lineLayer.removeAnimationForKey("origin.y")
    }
}

extension QRCodeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        if let ci = CIImage(image: image) {
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
            let features = detector.featuresInImage(ci)
            for feature in features {
                let info = (feature as! CIQRCodeFeature).messageString
                print(info)
            }
        }
    }
}

