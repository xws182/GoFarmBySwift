//
//  FirstViewController.swift
//  GoFarmBySwift
//
//  Created by 颜魏 on 15/7/4.
//  Copyright © 2015年 &#39068;&#39759;. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TrendsDisplayPhotoViewDelegate  {

    var tableView: UITableView!
    var tableHeader: UIView!
    var categoryView: TrendsDisplayPhotoView!
    var dataSource: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let database = DataBaseManager.shareInstance
        var users = [UserModel]()
        for i in 0..<2 {
            let user = UserModel()
            user.userId = "1"+"\(i)"
            user.userAccount = "888"+"\(i)"
            user.userName = "yanwei"+"\(i)"
            users.append(user)
        }
//        database.insertUser(users)
        database.getUserList()
        
        let user = UserModel()
        user.userId = "10"
        user.userAccount = "2880"
        user.userName = "neimei0"

        database.selectUserTable(user)
        
        database.getUserList()

        view.backgroundColor = UIColor.whiteColor()
        self.title = "首页"
        
        createTableHeader()
        createTableView()
        obtainDataSource()
    }
    
    //创建tableView的头部视图
    func createTableHeader() {
        let array = ["https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg", "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg",
            "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg",
            "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg",
            "https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg"]
        let titleArray = ["钓鱼岛是中国的，是不容侵犯的领土", "钓鱼岛是中国的，是不容侵犯的领土", "钓鱼岛是中国的，是不容侵犯的领土", "钓鱼岛是中国的，是不容侵犯的领土", "钓鱼岛是中国的，是不容侵犯的领土"]
        tableHeader = UIView(frame: CGRectMake(0, 0, view.bounds.width, 150 + (UIScreen.mainScreen().bounds.width-20-20)/3*2.0+10.0+10.0 + 30))
        let scrollImage = RepeatRollView()
        scrollImage.initSubViews(.ShowImageType, dataSource: array, direction: .LeftOrRightType)
        tableHeader!.addSubview(scrollImage)
        scrollImage.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(150)
        }
        
        categoryView = TrendsDisplayPhotoView()
        categoryView!.backgroundColor = UIColor.whiteColor()
        categoryView!.collectionView!.scrollEnabled = false
        categoryView!.dataSource = array
        
        categoryView!.delegate = self
        tableHeader!.addSubview(categoryView!)
        categoryView!.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(scrollImage.snp_bottom).offset(10)
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo((UIScreen.mainScreen().bounds.width-20-20)/3*2+10.0)
        }

        let scrollTitle = RepeatRollView()
        scrollTitle.initSubViews(.ShowTitleType, dataSource: titleArray, direction: .DownOrUpType)
        tableHeader!.addSubview(scrollTitle)
        scrollTitle.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(categoryView!.snp_bottom).offset(10)
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.height.equalTo(30)
        }
    }
    
    //创建tableView
    func createTableView() {
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView!.backgroundColor = UIColor.whiteColor()
        tableView!.tableHeaderView = tableHeader
        tableView!.tableFooterView = UIView()
        tableView!.delegate = self
        tableView!.dataSource = self
        view.addSubview(tableView!)
        tableView!.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.bottom.equalTo(0)
            make.right.equalTo(0)
        }
    }
    
    //获取数据源
    func obtainDataSource() {
        dataSource = NSMutableArray()
        for _ in 0 ..< 3 {
            let model = ProductModel()
            model.productIconImages = ["https://raw.githubusercontent.com/onevcat/Kingfisher/master/images/kingfisher-1.jpg"]
            model.productName = "农家土鸡"
            model.productOriginalPrice = "150"
            model.productNowPrice = "100"
            dataSource.addObject(model)
        }
        tableView.reloadData()
    }
    
    //tableView的代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120.0
    }
    
    //TrendsDisplayPhotoView的代理方法
    func trendsDisplayPhotoView(view: TrendsDisplayPhotoView, didSeletecdItem item: NSInteger) {
        let categoryVC = CategoryViewController()
        categoryVC.category = "农庄"
        categoryVC.hidesBottomBarWhenPushed = true
        self.navigationController!.showViewController(categoryVC, sender: nil)
        print("点击了第个\(item)Item", terminator: "")
    }
    
}
