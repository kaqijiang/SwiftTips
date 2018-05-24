//
//  ViewController.swift
//  [7]LongitudeLatitude
//
//  Created by Seven on 2018/5/22.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

import UIKit
import CoreLocation
/*
 
 地理编码地名 -> 经纬度
 反地理编码经纬度 ->地名
 
 CLGeocoder 类主要提供 具体经纬度和用户位置之间的转换。
 CLGeocoder将根据请求的所有信息决定返回什么类型的信息。如：用户是在高速上快速移动，可能返回整个区域的名称，而不是用户通过小公园的名称。地理编码对于每一个app都是有频率限制的，在较短的时间内进行太多的请求，可能会导致请求失败(当使用超过了最大的限制，地理编码将会返回应该错误对象kCLErrorNetwork)。下面有一些相关的使用规则：
 
 1）对于任意的用户行为，最多只发送一次请求。
 2）如果用户执行的多次请求涉及到相同的位置，应该重用最初的地理编码请求结果，存储到本地，下次直接使用。
 3）当想要自动更新用户的当前位置时(如：用户正在移动),要注意：仅仅是当用户已经移动一段距离并且有一段合理的时间才发起一个新的编码请求。例如：不应该在每分钟发送超过一个的编码请求。
 4）不要每次在用户不能够立马看到结果的时候，又开始一个编码请求。当应用处于后台绘制inactive状态不要进行请求操作。
 
 由于 ios 的地图必须根据精度和纬度来完成,因此如果需要让程序根据地址进行定位判断,则需要先把地址解析成精度,纬度.两个基本的概念：
 
 地理编码:把普通用户能够看懂的字符串地址转换成为精度,纬度.
 反向地理编码:把精度,纬度转换成普通的字符串地址.
 
 iOS为我们提供了3个方法来进行地理编码，一个方法进行反向地理编码，如下：
 
 ### reverse geocode requests 反向地理编码根据给定的经纬度得到对应的地址。
 
 当地理/反地理编码完成时，就会调用CLGeocodeCompletionHandler，可以获取到CLPlacemark对象. CLGeocodeCompletionHandler:这个block传递2个参数：error：当编码出错时（比如编码不出具体的信息）有值，placemarks：里面装着CLPlacemark对象
 
 1.publicfunc reverseGeocodeLocation(location: CLLocation, completionHandler: CLGeocodeCompletionHandler)
 
 
 ### forward geocode requests 地理编码 根据给定的字符串得到经纬度信息。
 
 1.publicfunc geocodeAddressDictionary(addressDictionary: [NSObject : AnyObject], completionHandler: CLGeocodeCompletionHandler)
 2.publicfunc geocodeAddressString(addressString: String, completionHandler: CLGeocodeCompletionHandler)
 //该方法跟前面方法差不多，区别在于多了一个CLRegion参数，该参数代表某个区域，这样可以提高编码解析的准确性。
 3.publicfunc geocodeAddressString(addressString: String, inRegion region: CLRegion?, completionHandler: CLGeocodeCompletionHandler)
 
 CLPlacemark类：CLPlacemark它存储了给定精度和纬度对应的地标数据。该对象包含了以下信息:
 
 public init(placemark: CLPlacemark)//使用一个CLPlacemark初始化一个CLPlacemark
 @NSCopyingpublicvar location: CLLocation? { get }//返回值封装了CLPlacemark对象代表的精度和纬度信息.
 @NSCopyingpublicvar region: CLRegion? { get }//对应placemark的地理区域
 @NSCopyingpublicvar timeZone: NSTimeZone? { get } //对应placemark的时区
 publicvar addressDictionary: [NSObject : AnyObject]? { get }//返回值封装了CLPlacemark所代表的地址详情信息.
 
 // address dictionary properties
 publicvar name: String? { get } //返回CLPlacemark所代表的地址名称.
 publicvar thoroughfare: String? { get } //所在地址的道路名
 publicvar subThoroughfare: String? { get } //所在地址的下级道路名
 publicvar locality: String? { get } //所在地址的城市名，市
 publicvar subLocality: String? { get } //下一级城市名, 区
 publicvar administrativeArea: String? { get } //返回CLPlacemark所代表行政区域 直辖市等没有的话返回nil ****
 publicvar subAdministrativeArea: String? { get } //返回CLPlacemark所代表次级行政区
 publicvar postalCode: String? { get } //代表所在地址的邮编
 publicvar ISOcountryCode: String? { get } //代表地址所在国家的代码.中国：CN
 publicvar country: String? { get } // 代表地址所在国家
 publicvar inlandWater: String? { get } //河流名称
 publicvar ocean: String? { get } //与Placemark相关的海洋
 publicvar areasOfInterest: [String]? { get } //与Placemark相关区域的兴趣点
 
 名词了解，天朝经纬度，火星坐标  祖国特有，对真实坐标系统进行人为的加偏处理，按照特殊的算法，将真实的坐标加密成虚假的坐标
 */
class ViewController: UIViewController {
    
    @IBOutlet weak var geocode_latitudeValue: UILabel!
    
    @IBOutlet weak var geoCode_longitudeValue: UILabel!
    
    @IBOutlet weak var geoCode_Address: UITextField!
    
    @IBOutlet weak var reGeoCode_Address: UILabel!
    
    @IBOutlet weak var reGeoCode_LatiudeValue: UITextField!
    
    @IBOutlet weak var reGeoCode_LongitudeValue: UITextField!
    
    @IBOutlet weak var geocodeError: UILabel!
    lazy var geocoder: CLGeocoder = {
        
        let geocoder: CLGeocoder = CLGeocoder()
        return geocoder
    }()
    
    override func viewDidLoad() {super.viewDidLoad()}
    
    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}
}
extension ViewController {
    
    @IBAction func reGeoCode_Conversion(_ sender: Any) {
        
        if let longitudeValue = reGeoCode_LongitudeValue,
            let latiudeValue = reGeoCode_LatiudeValue,
            latiudeValue.text != "",
            longitudeValue.text != "" {
            
            guard let latiudeValueNumber = Double(latiudeValue.text!),
                let longitudeValueNumber = Double(longitudeValue.text!) else {
                    return
            }
            
            let location = CLLocation(latitude: latiudeValueNumber, longitude: longitudeValueNumber)
            
            geocoder.reverseGeocodeLocation(location, completionHandler: { (placeMark, error) in
                
                if(error == nil) {
                    ///成功
                    if let place = placeMark?[0] {
                        //比如直辖市 place.administrativeArea 就是nil 所以需要特殊注意
                        guard let country = place.country,
                            let administrativeArea = place.administrativeArea,
                            let locality = place.locality,
                            let subLocality = place.subLocality,
                            let name = place.name else{
                                self.reGeoCode_Address.text = "解析失败"
                                return
                        }
                        
                        self.reGeoCode_Address.text = country + administrativeArea + locality + subLocality + name
                        print(place)
                        
                    }else {
                        self.reGeoCode_Address.text = "Sorry,解析出错了。"
                        return
                    }
                }else{
                    self.reGeoCode_Address.text = "Sorry,error=\(String(describing: error))"
                    return
                }
            })
        }
    }
}
extension ViewController {
    
    @IBAction func geoCode_Conversion(_ sender: UIButton) {
        
        //        @available(iOS, introduced: 5.0, deprecated: 11.0)
        //        geocoder.geocodeAddressString(<#T##addressString: String##String#>, completionHandler: <#T##CLGeocodeCompletionHandler##CLGeocodeCompletionHandler##([CLPlacemark]?, Error?) -> Void#>)
        
        //        @available(iOS 11.0, *)
        //        geocoder.geocodeAddressString(<#T##addressString: String##String#>, in: <#T##CLRegion?#>, preferredLocale: <#T##Locale?#>, completionHandler: <#T##CLGeocodeCompletionHandler##CLGeocodeCompletionHandler##([CLPlacemark]?, Error?) -> Void#>)
        
        
        if let areaText = self.geoCode_Address.text {
            
            geocoder.geocodeAddressString(areaText, in: nil) { (placemark, error) in
                if(error == nil){
                    
                    if let place = placemark?[0]{
                        
                        guard let name = place.name,
                            let country = place.country,
//                            let administrativeArea = place.administrativeArea,
                            let latiude = place.location?.coordinate.latitude,
                            let longitude = place.location?.coordinate.longitude else{
                                return
                        }
                        
                        self.geoCode_longitudeValue.text = String(longitude.description)
                        self.geocode_latitudeValue.text = String(latiude.description)
                        
//                        self.geocodeError.text = country + administrativeArea + name
                        self.geocodeError.text = country + name
                        print(place)
                    }else {
                        self.geocodeError.text = "error,解析失败"
                    }
                    
                }else{
                    self.geocodeError.text = String(describing: error)
                    return
                }
            }
        }else{
            self.geocodeError.text = "error,请输入地区"
        }
    }
}


