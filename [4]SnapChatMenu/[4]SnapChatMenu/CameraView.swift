//
//  CameraView.swift
//  [4]SnapChatMenu
//
//  Created by Seven on 2018/5/14.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

import UIKit
import AVFoundation
/*
 AVCaptureSession  对象来执行输入设备和输出设备之间的数据传递
 - startRunning stopRunning
 - sessionPreset 来定制输出的质量级别或比特率
 - canAddInput canAddOutput 判断是否可以加入会话
 - addInput addOutput 添加输入输出到会话
 
 
 AVCaptureDevice   捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）, 一个AVCaptureDevice实例,代表一种设备
 
 - 方法一
    直接根据类型去获取
    AVCaptureDevice.default(for: .video)
 - 方法二
    根据相机位置拿到对应摄像头
    设备位置枚举类型
        AVCaptureDevicePosition有3种(只针对摄像头,不针对麦克风):
        AVCaptureDevicePositionUnspecified = 0,//不确定
        AVCaptureDevicePositionBack        = 1,后置
        AVCaptureDevicePositionFront       = 2,前置
    设备种类:
        //AVCaptureDeviceType 设备种类
        AVCaptureDeviceTypeBuiltInMicrophone //麦克风
        AVCaptureDeviceTypeBuiltInWideAngleCamera //广角相机
        AVCaptureDeviceTypeBuiltInTelephotoCamera //比广角相机更长的焦距。只有使用 AVCaptureDeviceDiscoverySession 可以使用
        AVCaptureDeviceTypeBuiltInDualCamera //变焦的相机，可以实现广角和变焦的自动切换。使用同AVCaptureDeviceTypeBuiltInTelephotoCamera 一样。
 
        AVCaptureDevice.default(.builtInDualCamera, for: AVMediaType.video, position: .front)
 
 
 
 AVCaptureDeviceInput  输入捕获器,AVCaptureInput的一个子类,它提供了从AVCaptureDevice捕获的媒体数据。AVCaptureSession的输入源
 
 AVCaptureOutput 是一个抽象类,决定了捕捉会话(AVCaptureSession)输出什么(一个视频文件还是静态图片)
 
 AVCaptureMovieFileOutput
 用于输出视频到文件目录
 
 AVCaptureAudioFileOutput
 用于输出(相应格式的)音频到文件目录下
 
 AVCaptureStillImageOutput
 
 AVCapturePhotoOutput的一个抽象子类，用于将捕获的媒体静态图片
 用户可以在实时的捕获资源下实时获取到高质量的静态图片,通过captureStillImageAsynchronouslyFromConnection:completionHandler:方法(也就是点击拍照动作方法)
 用户还可以配置静态图像输出以生成特定图像格式的静态图像。
 AVCapturePhotoOutput/AVCaptureStillImageOutput不允许同时添加到捕捉会话中,否则会崩溃
 当用户需要详细监控拍照的过程那就可以通过设置代理来监控
 首先要创建并配置一个AVCapturePhotoSettings对象,然后通过 -capturePhotoWithSettings:delegate:设置代理
 监控状态主要有(照片即将被拍摄，照片已经捕捉，但尚未处理，现场照片电影准备好，等等)

 AVCapturePhotoSettings
 可以大量的设置照片的许多属性,针对AVCapturePhotoOutput ,类似于 AVCaptureStillImageOutput 的 outputSettings
 photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
 
 
 AVCaptureVideoPreviewLayer  预览图层,CALayer 的子类，自动显示相机产生的实时图像
 
 关系图 https://upload-images.jianshu.io/upload_images/2933617-f140b45119a237fe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700
 - 问题再连续多次点击的时候，遇到了崩溃，原因如下
 
    重要
    重复使用AVCapturePhotoSettings实例进行多次捕获是非法的。如果设置对象的uniqueID值与任何先前使用的设置对象的值相匹配，则调用capturePhoto（with：delegate :)方法将引发异常（invalidArgumentException）。
    要重新使用特定的设置组合，请使用init（from :)初始化程序从现有的照片设置对象创建一个新的，唯一的AVCapturePhotoSettings实例。
 

 */



class CameraView: UIViewController, UIPickerViewDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var cameraView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    var captureSession: AVCaptureSession?
    var stillImageOut: AVCapturePhotoOutput?
    var preViewLayer: AVCaptureVideoPreviewLayer?
    var photoSettings: AVCapturePhotoSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        preViewLayer?.frame = cameraView.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        captureSession = AVCaptureSession()
        
        captureSession?.sessionPreset = AVCaptureSession.Preset.hd1920x1080
        let backCamera = AVCaptureDevice.default(for: .video)
        AVCaptureDevice.default(.builtInDualCamera, for: AVMediaType.video, position: .front)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError {
            error = error1
            input = nil
        }
        
        if (error == nil && captureSession?.canAddInput(input) != nil) {
            captureSession?.addInput(input)
            
            stillImageOut = AVCapturePhotoOutput()
            
            photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
            
            stillImageOut?.photoSettingsForSceneMonitoring = photoSettings
            
            
            if (captureSession?.canAddOutput(stillImageOut!) != nil) {
                captureSession?.addOutput(stillImageOut!)
                
                preViewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
                
                preViewLayer?.videoGravity = AVLayerVideoGravity.resize
                preViewLayer?.connection?.videoOrientation = .portrait
                cameraView.layer.addSublayer(preViewLayer!)
                
                captureSession?.startRunning()
                
            }
        }
    }
    func didPressTakePhoto(){
        if let videoConnection = stillImageOut?.connection(with: .video) {
            videoConnection.videoOrientation = .portrait
            stillImageOut?.capturePhoto(with: photoSettings!, delegate: self)
        }
        
    }
    
    var didTakePhoto = Bool()
    
    func didPressTakeAnother() {
        
        captureSession?.startRunning()
        if didTakePhoto == true {
            imageView.isHidden = true
            didTakePhoto = false
        }else{
            captureSession?.startRunning()
            didTakePhoto = true
            didPressTakePhoto()
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        didPressTakeAnother()
    }
    
}
//MARK:-  AVCapturePhotoCaptureDelegate extension
extension CameraView: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            
            if let image = UIImage(data: imageData){
                imageView.image = image
                if captureSession?.isRunning ?? false {
                captureSession?.stopRunning()
                    
                    photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey : AVVideoCodecType.jpeg])
                    
                    stillImageOut?.photoSettingsForSceneMonitoring = photoSettings
                    
                }
                
            }
        }
    }
}

