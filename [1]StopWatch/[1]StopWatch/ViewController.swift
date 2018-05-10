//
//  ViewController.swift
//  [1]StopWatch
//
//  Created by Seven on 2018/5/10.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

import UIKit

/**
 
 知识点:
 1.stroyboard布局，拖拽
 2.重写preferredStatusBarStyle get方法，更换颜色
 3.定时器使用 Timer.scheduledTimer
 4.#selector()使用 @objc
 5.String(counter) String(format:"%.1f" ,counter)
 
 **/

class ViewController: UIViewController {
    
    
    @IBOutlet weak var times: UILabel!
    
    @IBOutlet weak var player: UIButton!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    
    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    
    //重写顶部状态栏颜色 defalt黑色
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //赋值，转换格式
        times.text = String(counter)
        pause.isEnabled = false
        resetButton.isEnabled = false
    }
    
    //开始事件
    @IBAction func player(_ sender: UIButton) {
        
        if isPlaying {
            return
        }
        
        player.isEnabled = false
        pause.isEnabled = true
        resetButton.isEnabled = true
        isPlaying = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseButtonDidTouch(_ sender: UIButton) {
        timer.invalidate()
        pause.isEnabled = false
        player.isEnabled = true
        isPlaying = false
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UIButton) {
        timer.invalidate()
        
        pause.isEnabled = false
        resetButton.isEnabled = false
        player.isEnabled = true
        counter = 0.0
        times.text = String(counter)
        isPlaying = false
    }
    
    @objc private func updateTimer() {
        counter += 0.1
        times.text = String(format:"%.1f" ,counter)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
