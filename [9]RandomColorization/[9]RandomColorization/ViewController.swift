//
//  ViewController.swift
//  [9]RandomColorization
//
//  Created by Seven on 2018/5/25.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

/*
 CAGradientLayer 梯度图层
 
 - colors 一个内部是CGColorRef的数组,规定所有的梯度所显示的颜色,默认为nil
 
 - locations 一个内部是NSNumber的可选数组,规定所有的颜色梯度的区间范围,选值只能在0到1之间,并且数组的数据必须单增,默认值为nil
 
 - startPoint 绘制阶梯图层的起点坐标,绘制颜色的起点,默认值是(0.5,0.0)
 
 - endPoint 图层颜色绘制的终点坐标,也就是阶梯图层绘制的结束点,默认值是(0.5,1.0)
 - type 绘制类型,默认值是kCAGradientLayerAxial,也就是线性绘制,各个颜色阶层直接的变化是线性的
 
 
 drand48
 */
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    let audioPlayer = AVAudioPlayer()
    
    var timer: Timer?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let musicPath = Bundle.main.path(forResource: "Ecstasy", ofType: "mp3") else {
            return
        }
        
        let musicUrl = URL(fileURLWithPath: musicPath)
        
        
        
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerIsDone), userInfo: nil, repeats: true)
        }
        
        let redColor = CGFloat(drand48())
        let greenColor = CGFloat(drand48())
        let blueColor = CGFloat(drand48())
        view.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
        
        gradientLayer.frame = view.bounds
        let color1 = UIColor(white: 0.5, alpha: 0.2).cgColor as CGColor
        let color2 = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.4).cgColor as CGColor
        let color3 = UIColor(red: 0, green: 1, blue: 0, alpha: 0.3).cgColor as CGColor
        let color4 = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3).cgColor as CGColor
        let color5 = UIColor(white: 0.4, alpha: 0.2).cgColor as CGColor
        
        gradientLayer.colors = [color1, color2, color3, color4, color5]
        gradientLayer.locations = [0.10, 0.30, 0.50, 0.70, 0.90]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)//左下角
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)//右上角
        view.layer.addSublayer(gradientLayer)
        
    }
    
    @objc func timerIsDone(){
        let redColor = CGFloat(drand48())
        let greenColor = CGFloat(drand48())
        let blueColor = CGFloat(drand48())
        
        view.backgroundColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: 1.0)
    }
    
    override func viewDidLoad() {super.viewDidLoad()}

    override func didReceiveMemoryWarning(){super.didReceiveMemoryWarning()}


}

