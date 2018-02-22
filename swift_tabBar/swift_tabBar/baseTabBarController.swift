//
//  baseTabBarController.swift
//  swift_tabBar
//
//  Created by kaqi on 2018/2/22.
//  Copyright © 2018年 myself. All rights reserved.
//

import UIKit

class baseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //获取json路径
        guard let jsonPath = Bundle.main.path(forResource: "File", ofType: "json") else {
            print("获取路径失败")
            return
        }
        //根据路径解析数据
        guard let jsonData = NSData.init(contentsOfFile: jsonPath) else {
            print("转换data失败")
            return
        }
        //解析
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData as Data , options: .mutableContainers) else {
            print("解析失败")
            return
        }
        //类型转换
        guard let dictArr = jsonObject as? [[String: AnyObject]] else {
            print("数组转换失败")
            return
        }
        for dict in dictArr {
            
            guard let vcName = dict["vcName"] as? String else {
                continue
            }
            guard let imageName = dict["imageName"] as? String else {
                continue
            }
            guard let titleName = dict["titleName"] as? String else {
                continue
            }
            
            addChildViewController(vcName: vcName, imageName: imageName, titleName: titleName)
            
        }
    }
    
    private func addChildViewController(vcName: String, imageName: String, titleName: String) {
        //获取命名空间 build setting -- packaging
        guard  let spaceName = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            print("获取命名空间失败")
            return
        }
        //拼接
        guard let childVcClass = NSClassFromString(spaceName + "." + vcName) else {
            print("拼接失败")
            return
        }
        //转换
        guard let childVcType = childVcClass as? UIViewController.Type else {
            print("类型转换失败")
            return
        }
        //创建控制器，设置tabBar
        let vc = childVcType.init()
        vc.title = titleName
        vc.tabBarItem.title = titleName
        vc.tabBarItem.image = UIImage(named: "\(imageName)_unselected")
        vc.tabBarItem.selectedImage = UIImage(named: "\(imageName)selected")
        
        //包装根控制器
        let nav = UINavigationController.init(rootViewController: vc)
        
        addChildViewController(nav)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
