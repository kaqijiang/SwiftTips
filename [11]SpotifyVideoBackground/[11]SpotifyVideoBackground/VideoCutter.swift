//
//  VideoCutter.swift
//  [11]SpotifyVideoBackground
//
//  Created by Seven on 2018/5/29.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//
/**
 
 # SpotifyVideoBackground
 ## AVAssetExportSession：
 ### 对象转码以及输出，对一个AVAsset对象进行视频处理输出
 ## AVPlayer：
 ### 控制播放器的播放，暂停，播放速度
 AVURLAsset : AVAsset 的一个子类，使用 URL 进行实例化，实例化对象包换 URL 对应视频资源的所有信息。
 AVPlayerItem：管理资源对象，提供播放数据源
 AVPlayerLayer：负责显示视频，如果没有添加该类，只有声音没有画面
 
 创建AVAssetExportSession对象
 压缩的质量
 AVAssetExportPresetLowQuality   最low的画质最好不要选择实在是看不清楚
 AVAssetExportPresetMediumQuality  使用到压缩的话都说用这个
 AVAssetExportPresetHighestQuality  最清晰的画质
 
CMTimeMakeWithSeconds(a,b)    a当前时间,b每秒钟多少帧.
 

 
## FileManager文件常用操作

### FileManager.default
#### 返回默认FileManager单例

### NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
#### Document路径
 s t p s c n d b w e b m
 
 candy not inproduction list
 */

import UIKit
import AVFoundation

extension String {
    var convert: NSString {return (self as NSString)}
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
        DispatchQueue.global(priority: priority).async {
         
            let asset = AVURLAsset(url: url, options: nil)
            //转码导出
            let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
            
            //沙盒
            let paths: NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            var outputURL = paths.object(at: 0) as! String
            
            //获取文件夹路径
            let manager = FileManager.default
            
            do {
                try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true, attributes: nil)
            }catch _ {
            }
            outputURL = outputURL.convert.appendingPathComponent("output.mp4")
            
            do{
                try manager.removeItem(atPath: outputURL)
            }catch _ {
            }
            
            if let exportSession = exportSession as AVAssetExportSession? {
                
                exportSession.outputURL = URL(fileURLWithPath: outputURL)
                exportSession.shouldOptimizeForNetworkUse = true
                exportSession.outputFileType = AVFileType.mp4
                let start = CMTimeMakeWithSeconds(Float64(startTime), 600)
                let duration = CMTimeMakeWithSeconds(Float64(duration), 600)
                let range = CMTimeRangeMake(start, duration)
                exportSession.timeRange = range
                exportSession.exportAsynchronously { () -> Void in
                    switch exportSession.status {
                    case AVAssetExportSessionStatus.completed:
                        completion?(exportSession.outputURL, nil)
                    case AVAssetExportSessionStatus.failed:
                        print("Failed: \(String(describing: exportSession.error))")
                    case AVAssetExportSessionStatus.cancelled:
                        print("Failed: \(String(describing: exportSession.error))")
                    default:
                        print("default case")
                    }
                }
            }
        }
    }
}
