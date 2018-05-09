//
//  ViewController.swift
//  [2]CusetonFont
//
//  Created by Seven on 2018/5/9.
//  Copyright © 2018年 seven. All rights reserved.
//

import UIKit
/**
 
 1.倒入字体
 2.tableView注册Identifier
 3.tableView的基本使用
 4.UIFont设置字体
 */
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //数据源
    var data = ["Learn swift", "Learn english", "这些字体特别适合打「奋斗」和「理想」", "谢谢「造字工房」，本案例不涉及商业使用", "使用到造字工房劲黑体，致黑体，童心体", "呵呵，再见🤗 See you next Project", "🤮🤮🤮😄😂23333333",
                "测试测试测试测试测试测试",
                "123",
                "Alex",
                "@@@@@@"];
    //字体 需要导入字体，同时设置info.plist
    var fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular", "Gaspar Regular","Zapfino"]

    var fontRowIndex = 0
    
    
    @IBOutlet weak var navItem: UINavigationItem!
    
    @IBOutlet weak var changeBtn: UIButton!
    
    @IBOutlet weak var fontTableView: UITableView!
    
    @IBAction func changeBtnClick(_ sender: UIButton) {
        
        fontRowIndex = (fontRowIndex + 1) % 5
        
        navItem.title = fontNames[fontRowIndex]
        
        fontTableView.reloadData()
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        navItem.title = "Custom Font"
        
        fontTableView.dataSource = self
        fontTableView.delegate = self
        
        changeBtn.layer.cornerRadius = 50
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = fontTableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath)
        
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        
        cell.textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        cell.textLabel?.font = UIFont(name: self.fontNames[fontRowIndex], size: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
   
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

