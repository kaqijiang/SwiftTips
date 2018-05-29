//
//  VideoCutter.swift
//  [11]SpotifyVideoBackground
//
//  Created by Seven on 2018/5/29.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//
/*
 AVAssetExportSession：对象转码以及输出，对一个AVAsset对象进行视频处理输出
 AVPlayer：控制播放器的播放，暂停，播放速度
 AVURLAsset : AVAsset 的一个子类，使用 URL 进行实例化，实例化对象包换 URL 对应视频资源的所有信息。
 AVPlayerItem：管理资源对象，提供播放数据源
 AVPlayerLayer：负责显示视频，如果没有添加该类，只有声音没有画面
 
 创建AVAssetExportSession对象
 压缩的质量
 AVAssetExportPresetLowQuality   最low的画质最好不要选择实在是看不清楚
 AVAssetExportPresetMediumQuality  使用到压缩的话都说用这个
 AVAssetExportPresetHighestQuality  最清晰的画质
 
 */

import UIKit

extension String {
    var convert: String {return (self as String)}
}
class VideoCutter: NSObject {

    /**
     Block based method for crop video url
     
     @param videoUrl Video url
     @param startTime The starting point of the video segments
     @param duration Total time, video length
     
     */
    
    open func cropVideoWithUrl(videoUrl url: URL, startTime: CGFloat, duration: CGFloat, completion:((_ videoPath: URL?, _ error: NSError?) -> Void)?){
        
        let priority = DispatchQueue.GlobalQueuePriority.default
    }
}
