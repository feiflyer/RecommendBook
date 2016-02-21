//
//  CommnentViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/2/21.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class CommnentViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    var bookObject: AVObject?
    var tableView: UITableView!
    var commentArray = [AVObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        let btn = self.view.viewWithTag(1234)
        btn?.hidden = true
        
        let titleLabel = UILabel(frame: CGRectMake(0,20,SCREEN_WIDTH,44))
        titleLabel.text = "讨论区"
        titleLabel.font = UIFont(name: MAIN_FONT, size: 17)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = MAIN_RED
        self.view.addSubview(titleLabel)
        
        self.tableView = UITableView(frame: CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HIGHT - 64 - 44))
        self.tableView?.registerClass(DiscussCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.tableFooterView = UIView()
        self.view.addSubview(self.tableView!)
        
        
        self.tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "headerRefresh")
        self.tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: "footerRefresh")
        

    }
    //关闭按钮点击事件
    func sure(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    /**
     *  UITableViewdelegate,UItableViewDataSource
     */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? DiscussCell
         //此时cell的高度时计算好的
        cell?.initFrame()
        let object = commentArray[indexPath.row]
        
        let user = object["user"] as? AVUser
        cell?.nameLabel?.text = user?.username
        
        cell?.avatarImage?.image = UIImage(named: "Avatar")
        
        let date = object["createdAt"] as? NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm"
        cell?.dateLabel?.text = format.stringFromDate(date!)
        
        cell?.detailLabel?.text = object["text"] as? String
        
        
        return cell!
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let object = commentArray[indexPath.row]
        let text = object["text"] as? NSString
        //计算文字
        let textSize = text?.boundingRectWithSize(CGSizeMake(SCREEN_WIDTH-56-8,0), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15)], context: nil).size
        
        return (textSize?.height)! + 30 + 25
    }
    
    /**
     *  上拉加载、下啦刷新
     */
    func headerRefresh(){
        let query = AVQuery(className: "discuss")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = 0
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("BookObject", equalTo: bookObject)
        query.includeKey("user")
        query.includeKey("BookObject")
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableView?.mj_header.endRefreshing()
            
            self.commentArray.removeAll()
              self.commentArray.appendContentsOf(results as! [AVObject])
            self.tableView?.reloadData()
        }
    }
    
    func footerRefresh(){
        let query = AVQuery(className: "discuss")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = self.commentArray.count
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("BookObject", equalTo: self.bookObject)
        query.includeKey("user")
        query.includeKey("BookObject")
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableView?.mj_footer.endRefreshing()
            self.commentArray.appendContentsOf(results as! [AVObject])
            self.tableView?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
