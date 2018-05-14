//
//  ViewController.swift
//  [4]SnapChatMenu
//
//  Created by Seven on 2018/5/10.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

import UIKit

/*
 - xib初步使用
 - 配置info.plist
 - UIScrollView初步使用
 - 属性，contentSize，bounces，isPagingEnabled
 - AVFoundation  AVCaptureSession AVCaptureDevice AVCaptureDeviceInput AVCaptureOutput AVCapturePhotoOutput AVCapturePhotoSettings AVCaptureVideoPreviewLayer 的使用
 - 详细说明在文件内
 - 参考https://www.jianshu.com/p/731ec03c5fcb
 
*/
class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isStatusBarHidden = true
        
        let leftViews: leftView = leftView(nibName: "leftView", bundle:nil)
        let centerViews: CameraView = CameraView(nibName: "CameraView", bundle: nil)
        let rightViews: rightView = rightView(nibName: "rightView", bundle: nil)
        
        self.addChildViewController(leftViews)
        self.scrollView.addSubview(leftViews.view)
        leftViews.didMove(toParentViewController: self)
        
        self.addChildViewController(centerViews)
        self.scrollView.addSubview(centerViews.view)
        centerViews.didMove(toParentViewController: self)
        
        self.addChildViewController(rightViews)
        self.scrollView.addSubview(rightViews.view)
        rightViews.didMove(toParentViewController: self)
        
        var centerViewFrame = scrollView.frame
        centerViewFrame.origin.x = self.view.bounds.width
        centerViews.view.frame = centerViewFrame
        
        var rightViewFrame = scrollView.frame
        rightViewFrame.origin.x = 2 * self.view.bounds.width
        rightViews.view.frame = rightViewFrame
        
        self.scrollView.contentSize = CGSize(width: 3 * self.view.bounds.size.width, height: self.view.bounds.size.height)
        self.scrollView.bounces = false
        self.scrollView.isPagingEnabled = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

