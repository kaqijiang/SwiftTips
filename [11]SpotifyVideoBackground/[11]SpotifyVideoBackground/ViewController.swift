//
//  ViewController.swift
//  [11]SpotifyVideoBackground
//
//  Created by Seven on 2018/5/29.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

import UIKit

class ViewController: VideoSplashViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVideoBackground()
        loginButton.layer.cornerRadius = 4
        signupButton.layer.cornerRadius = 4
    }

    private func setupVideoBackground(){
        
        //获取路径
        guard let bundlePatch = Bundle.main.path(forResource: "moments", ofType: "mp4") else {
            print("路径错误")
            return
        }
        let url = URL(fileURLWithPath: bundlePatch)
        
        videoFrame = view.frame
        startTime = 2.0
        sound = true
        alpha = 0.8
        contentURL = url
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        
        view.isUserInteractionEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

