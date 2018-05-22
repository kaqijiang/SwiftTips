//
//  ViewController.swift
//  [6]MyLocation
//
//  Created by Seven on 2018/5/22.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

/**
 extension 不允许存储读写属性
 
 info.plist 需要增加权限提示
 Privacy - Location When In Use Usage Description   允许在前台获取GPS的描述
 Privacy - Location Always Usage Description        允许在前后台获取GPS的描述
 
 app如果不需要后台获取GPS的话，不建议添加，否则上线审核会出现问题，如果需要需要做一些声明描述：GPS在后台持续运行，可以大大降低电池的寿命。
 
 ### CLLocationManager   定位管理
 
 locationServicesEnabled 当前定位服务是否可用
 
 deferredLocationUpdatesAvailable 延迟定位更新是否可用
 
 significantLocationChangeMonitoringAvailable 大位置改变监听是否可用
 
 headingAvailable 是否支持磁力计计算方向
 
 distanceFilter 距离筛选器,表示设备至少移动n米,才通知委托更新
 
 pausesLocationUpdatesAutomatically 设置iOS设备是否可暂停定位来节省电池的电量。如果该属性设为“YES”，则当iOS设备不再需要定位数据时，iOS设备可以自动暂停定位。
 
 activityType:设置定位数据的用途
 CLActivityTypeOther 定位数据作为普通用途
 CLActivityTypeAutomotiveNavigation定位数据作为车辆导航使用
 CLActivityTypeFitness 定位数据作为步行导航
 CLActivityTypeOtherNavigation定位数据作为其他导航

 desiredAccuracy 所需要精度 枚举值            含义
 kCLLocationAccuracyBestForNavigation    最适合导航
 kCLLocationAccuracyBest                 精度最好的
 kCLLocationAccuracyNearestTenMeters     附近10米
 kCLLocationAccuracyHundredMeters        附近100米
 kCLLocationAccuracyKilometer            附近1000米
 kCLLocationAccuracyThreeKilometers      附近3000米
 
 allowsBackgroundLocationUpdates ios9以上 是否允许后台更新定位 同时：target-Capabilities-Background Modes-location updates打钩
 
 
 ### CLPlacemark
 
 thoroughfare     街道
 subThoroughfare  子街道
 locality         市
 subLocality      区
 
 
 地理编码:把普通用户能够看懂的字符串地址转换成为精度,纬度.
 反向地理编码:把精度,纬度转换成普通的字符串地址.
 
 火星坐标
 
 CLLocationDegreeslatitude 纬度
 CLLocationDegreeslongitude 经度
 
 */

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager: CLLocationManager!
    
    @IBOutlet weak var locationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    @IBAction func myLocationButtonDidTouch(_ sender: UIButton) {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationLabel.text = "Error while updating location" + error.localizedDescription
    }
    //每当请求到位置信息时, 都会调用此方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //地理编码获取经纬度信息。
        CLGeocoder().reverseGeocodeLocation(manager.location!) { (placemarks, error) in
            
            if(error != nil) {
                self.locationLabel.text = "Reverse geocoder failed with error" + error!.localizedDescription
                return
            }else {
                if(placemarks!.count > 0){
                    let pm = placemarks?.first
                    self.displayLocationInfo(pm)
                }else {
                    self.locationLabel.text = "Problem with the data received from geocoder"
                }
            }
            }
        }
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
        
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            
            let thoroughfare = (containsPlacemark.thoroughfare != nil) ? containsPlacemark.thoroughfare : ""
        
            self.locationLabel.text = postalCode! + "" + locality!
            
            self.locationLabel.text?.append("\n" + country! + administrativeArea!)
            
            self.locationLabel.text?.append("\n" + thoroughfare!)
            
        }
    }
}

