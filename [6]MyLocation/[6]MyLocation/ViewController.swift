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
 
 desiredAccuracy 所需要精度 枚举值            含义
 
 kCLLocationAccuracyBestForNavigation    最适合导航
 kCLLocationAccuracyBest                 精度最好的
 kCLLocationAccuracyNearestTenMeters     附近10米
 kCLLocationAccuracyHundredMeters        附近100米
 kCLLocationAccuracyKilometer            附近1000米
 kCLLocationAccuracyThreeKilometers      附近3000米
 
 地理编码:把普通用户能够看懂的字符串地址转换成为精度,纬度.
 反向地理编码:把精度,纬度转换成普通的字符串地址.
 
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
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.locationLabel.text = "Error while updating location" + error.localizedDescription
    }
    //每当请求到位置信息时, 都会调用此方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
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

