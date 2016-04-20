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

class QRCodeViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            input = try AVCaptureDeviceInput(device: device)
        } catch let error as NSError {
            print("error:\(error)\n")
        }
        
        self.output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        self.session.sessionPreset = AVCaptureSessionPresetHigh
        if(self.session.canAddInput(self.input!)){
            self.session.addInput(self.input)
        }
        if(self.session.canAddOutput(self.output)){
            self.session.addOutput(self.output)
        }
        // 条码类型 AVMetadataObjectTypeQRCode
        self.output.metadataObjectTypes = [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
        
        view.backgroundColor = UIColor(white: 0, alpha: 0.2)
        navigationController?.navigationBar.hidden = true
        //扫码区域
        initBoxView()
        initView()
        
        self.preview = AVCaptureVideoPreviewLayer(session: self.session)
        self.preview!.frame = self.view.frame
        self.view.layer.insertSublayer(self.preview!, atIndex: 0)
        
        
        self.session.startRunning()
    }
    
    func initView() {
        let wrapView = UIView().addTo(view).withBack(UIColor(red: 0, green: 0, blue: 0, alpha: 0.6))
        wrapView.snp_makeConstraints { (make) in
            make.left.right.bottom.equalTo(view)
            make.height.equalTo(100)
        }
        let btn = UIButton().addTo(wrapView)
        let imageflash = UIImageView(image: UIImage(named: "qr_flash_nor")).addTo(btn)
        btn.snp_makeConstraints { (make) in
            make.centerX.centerY.equalTo(wrapView)
        }
    }
    
    func initBoxView() {
        let wrapView = QRCodeWrapView().addTo(view)
        wrapView.snp_makeConstraints { (make) in
            make.left.right.top.bottom.equalTo(view)
        }
        wrapView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        
        boxView.addTo(view).frame = CGRect(x: view.frame.width / 2 - 125, y: 100, width: 250, height: 250)
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
        
        let val0 = NSValue(CGPoint: CGPoint(x: lineLayer.position.x, y: -120))
        let val1 = NSValue(CGPoint: CGPoint(x: lineLayer.position.x, y: 250))
        animate1.autoreverses = false
        animate1.fillMode = kCAFillModeForwards
        animate1.repeatCount = MAXFLOAT
        animate1.duration = 1
        animate1.values = [val0, val1]
        lineLayer.addAnimation(animate1, forKey: "origin.y")
        
    }
    let lineLayer = CALayer()
    let animate1 = CAKeyframeAnimation(keyPath: "position")
    
    func startAnimation() {
        let pausedTime = lineLayer.timeOffset
        
        lineLayer.speed = 1
        lineLayer.timeOffset = 0
        lineLayer.beginTime = 0
        
        let timePause = lineLayer.convertTime(CACurrentMediaTime(), toLayer: nil) - pausedTime
        lineLayer.beginTime = timePause
        
    }
    
    func stopAnimation() {
        let pausedTime = lineLayer.convertTime(CACurrentMediaTime(), toLayer: nil)
        lineLayer.speed = 0
        lineLayer.timeOffset = pausedTime
    }
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        if(metadataObjects == nil || metadataObjects.count == 0){ return }
        self.session.stopRunning()
        print(metadataObjects)
        stopAnimation()
        async_queue("scan") { 
            sleep(3)
            self.async_main({
                self.startAnimation()
                self.session.startRunning()
            })
        }
        
    }
}

