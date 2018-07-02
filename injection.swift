//
//  injection.swift
//  s
//
//  Created by Seven on 2018/6/15.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

import UIKit

extension UIViewController { //5
    
    #if DEBUG //1
    @objc func injected() { //2
        for subview in self.view.subviews { //3
            subview.removeFromSuperview()
        }
        
        viewDidLoad() //4
    }
    #endif
}

/**
 //If you use CALayer for making animations, you’ll want to add the following code snippet.
 
 import UIKit
 
 extension UIViewController {
 
 #if DEBUG
 @objc func injected() {
 
 for subview in self.view.subviews {
 subview.removeFromSuperview()
 }
 if let sublayers = self.view.layer.sublayers {
 for sublayer in sublayers {
 sublayer.removeFromSuperlayer()
 }
 }
 
 viewDidLoad()
 }
 #endif
 }
 */

//import UIKit

//extension UIViewController {
//
//    #if DEBUG
//    @objc func injected() {
//
//        if self is UITabBarController == false {
//            for subview in self.view.subviews {
//                subview.removeFromSuperview()
//            }
//            for sublayer in self.view.layer.sublayers ?? [] {
//                sublayer.removeFromSuperlayer()
//            }
//        }
//
//        self.awakeFromNib()
//        self.viewDidLoad()
//        self.reloadInputViews()
//
//        if self is UITableViewController, let tableViewController = self as? UITableViewController {
//            tableViewController.tableView.reloadData()
//        }
//    }
//    #endif
//}
