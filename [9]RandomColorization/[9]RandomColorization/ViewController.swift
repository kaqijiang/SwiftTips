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
 
 
 ### drand48
 
 ### Url 不能用 if let  guard let 因为URL不是必选
 
 
 ### AVAudioSession
 
 AVAudioSession类由AVFoundation框架引入。每个iOS应用都有一个音频会话，它是一个单例对象，可以使用它来设置应用程序的音频上下文环境，并向系统表达您的应用程序音频行为的意图。
 
 - AVAudioSession.sharedInstance()
 
 Session默认行为
 可以进行播放，但是不能进行录制。
 当用户将手机上的静音拨片拨到“静音”状态时，此时如果正在播放音频，那么播放内容会被静音。
 当用户按了手机的锁屏键或者手机自动锁屏了，此时如果正在播放音频，那么播放会静音并被暂停。
 如果你的App在开始播放的时候，此时QQ音乐等其他App正在播放，那么其他播放器会被静音并暂停。
 默认的行为相当于设置了Category为“AVAudioSessionCategorySoloAmbient”
 
 Category设置
 
 七大Category
 AVAudioSession将音频的场景分成七类，通过设置Session为不同类别，可控：
 
 当App激活Session的时候，是否会打断其他不支持混音的App声音
 当用户触发手机上的“静音”键时或者锁屏时，是否相应静音
 当前状态是否支持录音
 当前状态是否支持播放
 每个App启动时都会设置成默认状态，即其他App会被中断同时相应“静音”键的播放模式。通过下表可以细分每个类别的支持情况：

 类别                                 当按“静音”或者锁屏是是否静音    是否引起不支持混音的App中断    是否支持录音和播放
 AVAudioSessionCategoryAmbient                  是                       否                    只支持播放
 AVAudioSessionCategoryAudioProcessing                   -    都不支持
 AVAudioSessionCategoryMultiRoute               否                       是                 既可以录音也可以播放
 AVAudioSessionCategoryPlayAndRecord            否                       默认不引起           既可以录音也可以播放
 AVAudioSessionCategoryPlayback                 否                       默认引起               只用于播放
 AVAudioSessionCategoryRecord                   否                       是                    只用于录音
 AVAudioSessionCategorySoloAmbient              是                       是                    只用于播放
 
 七大模式
 
 模式                                            场景
 AVAudioSessionModeDefault                    默认的模式
 AVAudioSessionModeVoiceChat                    VoIP
 AVAudioSessionModeGameChat      游戏录制，由GKVoiceChat自动设置，无需手动调用
 AVAudioSessionModeVideoRecording             录制视频时
 AVAudioSessionModeMoviePlayback               视频播放
 AVAudioSessionModeMeasurement                 最小系统
 AVAudioSessionModeVideoChat                   视频通话
 
 App启动会激活唯一的AVAudioSession，但是最好还是在自己ViewController的viewDidLoad里面再次进行激活：
 setActive。 激活
 setCategory 设置类别
 
 
 参考 https://www.jianshu.com/p/3e0a399380df
 */
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let gradientLayer = CAGradientLayer()
    var audioPlayer = AVAudioPlayer()
    
    var timer: Timer?

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let musicPath = Bundle.main.path(forResource: "Ecstasy", ofType: "mp3") else {
            return
        }
        
        let musicUrl = URL(fileURLWithPath: musicPath)
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            try AVAudioSession.sharedInstance().setActive(true)
            try audioPlayer = AVAudioPlayer(contentsOf: musicUrl)
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch let audioError as NSError {
            print(audioError)
        }
        
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

