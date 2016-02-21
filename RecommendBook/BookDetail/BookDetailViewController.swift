//
//  BookDetailControllerViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/2/19.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    var bookObject: AVObject?
    
    var BookTitleView:BookDetailView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        //设置导航条的颜色值
        navigationController?.navigationBar.tintColor = UIColor.grayColor()
        //设置导航条的字体上移60像素，使之移出到屏幕之外，效果就是只看到返回图标，看不到“返回”字体
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics: .Default)
        
        initBookDetailView()
    }
    
    /**
     *  初始化BookDetailView
     */
    func initBookDetailView(){
        BookTitleView = BookDetailView(frame: CGRectMake(0,64,SCREEN_WIDTH  ,SCREEN_HIGHT/4))
        view.addSubview(self.BookTitleView!)
        
        let coverFile = bookObject!["cover"] as? AVFile
        BookTitleView?.cover?.sd_setImageWithURL(NSURL(string: (coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        
        BookTitleView?.BookName?.text = "《"+(bookObject!["BookName"] as! String) + "》"
        BookTitleView?.Editor?.text = "作者："+(bookObject!["BookEditor"] as! String)
        
        let user = bookObject!["user"] as? AVUser
        user?.fetchInBackgroundWithBlock({ (returnUser, error) -> Void in
            self.BookTitleView?.userName?.text = "编者："+(returnUser as! AVUser).username
        })
        
        let date = bookObject!["createdAt"] as? NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yy-MM-dd"
        self.BookTitleView?.date?.text = format.stringFromDate(date!)
        
        let score = bookObject!["score"] as? NSNumber
        BookTitleView?.score?.show_star = (score?.integerValue)!
        
        let scanNumber = bookObject!["scanNumber"] as? NSNumber
        let loveNumber = bookObject!["loveNumber"] as? NSNumber
        let discussNumber = bookObject!["discussNumber"] as? NSNumber
        
        self.BookTitleView?.more?.text = (loveNumber?.stringValue)!+"个喜欢."+(discussNumber?.stringValue)!+"次评论."+(scanNumber?.stringValue)!+"次浏览"
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("photoBrowser"))
        self.BookTitleView?.cover?.addGestureRecognizer(tap)
        self.BookTitleView?.cover?.userInteractionEnabled = true
        
        bookObject?.incrementKey("scanNumber")
        bookObject?.saveInBackground()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
