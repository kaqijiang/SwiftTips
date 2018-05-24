//
//  ViewController.swift
//  [8]pulltorefresh
//
//  Created by Seven on 2018/5/24.
//  Copyright © 2018年 侯伟杰. All rights reserved.
//

/*
 UIRefreshControl 的基本使用
 tableView 的基本使用
 
 UINavigationBar 的基本使用
 */

import UIKit

class ViewController: UIViewController {

    static let cellIdentifer = "NewCellIdentifier"
    
    let favoriteEmoji = ["🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆"]
    
    let newFavoriteEmoji = ["🏃🏃🏃🏃🏃", "💩💩💩💩💩", "👸👸👸👸👸", "🤗🤗🤗🤗🤗", "😅😅😅😅😅", "😆😆😆😆😆" ]
    
    var emojiData = [String]()
    
    var tableVeiwController = UITableViewController(style: .plain)
    
    var refreshControl = UIRefreshControl()
    
    var navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 375, height: 64))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emojiData = favoriteEmoji
        
        let emojiTableView = tableVeiwController.tableView
        
        emojiTableView?.backgroundColor = UIColor(red:0.092, green:0.096, blue:0.116, alpha:1)
        emojiTableView?.delegate = self
        emojiTableView?.dataSource = self
        emojiTableView?.register(UITableViewCell.self, forCellReuseIdentifier: ViewController.cellIdentifer)
        
        emojiTableView?.refreshControl = refreshControl
        
        refreshControl.addTarget(self, action: #selector(didRoadEmoji), for: .valueChanged)
        
        self.refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.refreshControl.attributedTitle = NSAttributedString(string: "Last updated on \(Date())", attributes: attributes)
        self.refreshControl.tintColor = UIColor.white
        
        self.title = "emoji"
        self.navBar.barStyle = UIBarStyle.black
        
        self.navBar.isTranslucent = true
        
        emojiTableView?.rowHeight = UITableViewAutomaticDimension
        emojiTableView?.estimatedRowHeight = 60.0
        emojiTableView?.tableFooterView = UIView(frame: CGRect.zero)
        
        emojiTableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        
        view.addSubview(emojiTableView!)
        view.addSubview(navBar)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func didRoadEmoji() {
        self.emojiData = self.newFavoriteEmoji
        self.tableVeiwController.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ViewController.cellIdentifer, for: indexPath) as UITableViewCell
        cell.textLabel?.text = self.emojiData[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 50)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle =  UITableViewCellSelectionStyle.none
        return cell
    }
}
