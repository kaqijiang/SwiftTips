//
//  ViewController.swift
//  [3]PlayLocalVideo
//
//  Created by Seven on 2018/5/10.
//  Copyright © 2018年 seven. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
/**
 1.extension的使用。
 2.自定义cell的使用
 3.结构体
 4.Bundle路径
 5.AVKit AVFoundation初步使用
 
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var videoTableView: UITableView!
    
    let date = [
        video(image: "videoScreenshot01", title: "Introduce 3DS Mario", source: "Youtube - 06:32"),
        video(image: "videoScreenshot02", title: "Emoji Among Us", source: "Vimeo - 3:34"),
        video(image: "videoScreenshot03", title: "Seals Documentary", source: "Vine - 00:06"),
        video(image: "videoScreenshot04", title: "Adventure Time", source: "Youtube - 02:39"),
        video(image: "videoScreenshot05", title: "Facebook HQ", source: "Facebook - 10:20"),
        video(image: "videoScreenshot06", title: "Lijiang Lugu Lake", source: "Allen - 20:30")
    ]
    
    var playerView = AVPlayer()
    var playerViewController = AVPlayerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }
    
    @IBAction func playerDidClick(_ sender: UIButton) {
        let patch = Bundle.main.path(forResource: "emoji zone", ofType: "mp4")
        playerView = AVPlayer(url: URL(fileURLWithPath: patch!))
        playerViewController.player = playerView
        
        self.present(playerViewController, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView .dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        
        let video = date[indexPath.row]
        
        cell.videoScreenshot.image = UIImage(named: video.image)
        cell.videoTitleLabel.text = video.title
        cell.videoTitleSource.text = video.source
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
}

