//
//  ViewController.swift
//  [11]SpotifyVideoBackground
//
//  Created by Seven on 2018/5/29.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

