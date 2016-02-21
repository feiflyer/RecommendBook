//
//  PushViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class PushViewController: UIViewController ,UITableViewDataSource , UITableViewDelegate{
    var dataArray: Array<AVObject> = []
    var tableView: UITableView!
    var navigationBar: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        setNavigationBar()
        tableView = UITableView(frame: view.frame)
        tableView.delegate = self
        tableView.dataSource = self
        //除去多余的分割线
        tableView.tableFooterView = UIView()
        tableView.registerClass(PushBookCellTableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("headerRefresh"))
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: Selector("footerRefresh"))
        tableView.mj_header.beginRefreshing()
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationBar.hidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
         navigationBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
      //设置标题栏
    func setNavigationBar(){
        navigationBar = UIView(frame: CGRectMake(0 , -20 , SCREEN_WIDTH , 65))
        self.navigationController?.navigationBar.addSubview(navigationBar)
        
        let bookAddBtn = UIButton(frame: CGRectMake(20, 20, SCREEN_WIDTH, 45))
        bookAddBtn.setImage(UIImage(named: "plus circle"), forState: .Normal)
        bookAddBtn.setTitle("  新建书评", forState: .Normal)
        bookAddBtn.titleLabel?.font = UIFont(name: MAIN_FONT, size: 15)
        bookAddBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        //文字居左
        bookAddBtn.contentHorizontalAlignment = .Left
        bookAddBtn.addTarget(self, action: Selector("pushNewBook"), forControlEvents: .TouchUpInside)
        navigationBar.addSubview(bookAddBtn)
    }
    
    //新建书评按钮点击事件
    func pushNewBook(){
        print("新建书评")
        let pusnNewBookController = PushNewBookViewController()
        presentViewController(pusnNewBookController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! PushBookCellTableViewCell
        
        let dict = self.dataArray[indexPath.row]
        
        cell.bookName?.text = "《"+(dict["BookName"] as! String)+"》:"+(dict["title"] as! String)
        cell.editor?.text = "作者:"+(dict["BookEditor"] as! String)
        
        let date = dict["createdAt"] as? NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm"
        cell.more?.text = format.stringFromDate(date!)
        
        let coverFile = dict["cover"] as? AVFile
        cell.cover?.sd_setImageWithURL(NSURL(string: (coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    
    //item的点击事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //取消点击效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = BookDetailViewController()
        vc.bookObject = dataArray[indexPath.row]
        //隐藏tableBar
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //下拉刷新
    func headerRefresh(){
        let query = AVQuery(className: "Book")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = 0
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableView?.mj_header.endRefreshing()
            
        self.dataArray.removeAll()
            if results != nil{
                for data in results{
                    self.dataArray.append(data as! AVObject)
                }
            }
        self.tableView?.reloadData()
            
        }
    }
    
    //上拉加载
    func footerRefresh(){
        let query = AVQuery(className: "Book")
        query.orderByDescending("createdAt")
        query.limit = 20
        //跳过几个对象
        query.skip = self.dataArray.count
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
        self.tableView?.mj_footer.endRefreshing()
            if results != nil{
                for data in results{
                    self.dataArray.append(data as! AVObject)
                }
            }
        self.tableView?.reloadData()
            
        }
    }

}
