//
//  BookDetailControllerViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/2/19.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController , BookTabBarDelegate , InputViewDelegate , HZPhotoBrowserDelegate{
    var bookObject: AVObject?
    
    var BookTitleView: BookDetailView?
    var BookViewTabbar: BookTabBar?
    var BookTextView: UITextView?
    
    var input:InputView?
    
    var layView:UIView?
    
    var keyBoardHeight:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        //设置导航条的颜色值
        navigationController?.navigationBar.tintColor = UIColor.grayColor()
        //设置导航条的字体上移60像素，使之移出到屏幕之外，效果就是只看到返回图标，看不到“返回”字体
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics: .Default)
        
        initBookDetailView()
        
        BookViewTabbar = BookTabBar(frame: CGRectMake(0,SCREEN_HIGHT - 40,SCREEN_WIDTH,40))
        view.addSubview(BookViewTabbar!)
        BookViewTabbar?.delegate = self
        
        BookTextView = UITextView(frame: CGRectMake(0,64+SCREEN_HIGHT/4,SCREEN_WIDTH,SCREEN_HIGHT - 64 - SCREEN_HIGHT/4-40))
        //不能编辑
        BookTextView?.editable = false
        BookTextView?.text = bookObject!["description"] as? String
        view.addSubview(self.BookTextView!)
        
        isLove()
    }
    
    /**
     是否点赞初始化
     
     */
    func isLove(){
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("BookObject", equalTo: bookObject)
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if results != nil && results.count != 0{
                let btn = self.BookViewTabbar?.viewWithTag(2) as? UIButton
                btn?.setImage(UIImage(named: "solidheart"), forState: .Normal)
            }
        }
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
        //以下两句一般配套使用
        self.BookTitleView?.cover?.addGestureRecognizer(tap)
        self.BookTitleView?.cover?.userInteractionEnabled = true

        bookObject?.incrementKey("scanNumber")
        bookObject?.saveInBackground()
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     InputViewDelegate
     */
    func publishButtonDidClick(button: UIButton!) {
        ProgressHUD.show("")
        
        let object = AVObject(className: "discuss")
        object.setObject(self.input?.inputTextView?.text, forKey: "text")
        object.setObject(AVUser.currentUser(), forKey: "user")
        object.setObject(bookObject, forKey: "BookObject")
        object.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                self.input?.inputTextView?.resignFirstResponder()
                ProgressHUD.showSuccess("评论成功")
                
                self.bookObject?.incrementKey("discussNumber")
                self.bookObject?.saveInBackground()
            }else{
                
            }
        }
    }

    
    func textViewHeightDidChange(height: CGFloat) {
        self.input?.height = height+10
        self.input?.bottom = SCREEN_HIGHT - self.keyBoardHeight
    }
    
    func keyboardWillHide(inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: NSTimeInterval, animationCurve: UIViewAnimationCurve) {
        
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            //键盘消失的时候要把输入框移动到屏幕的外部
            self.input?.bottom = SCREEN_HIGHT+(self.input?.height)!
            self.layView?.alpha = 0
            }) { (finish) -> Void in
                
                self.layView?.hidden = true
                
        }
    }
    
    func keyboardWillShow(inputView: InputView!, keyboardHeight: CGFloat, animationDuration duration: NSTimeInterval, animationCurve: UIViewAnimationCurve) {
        self.keyBoardHeight = keyboardHeight
        UIView.animateWithDuration(duration, delay: 0, options: .BeginFromCurrentState, animations: { () -> Void in
            self.input?.bottom = SCREEN_HIGHT - keyboardHeight
            self.layView?.alpha = 0.2
            }) { (finish) -> Void in
                
        }
    }

    
    /**
    BookTabBarDelegate
    */
    func comment(){
        if self.input == nil {
            self.input = NSBundle.mainBundle().loadNibNamed("InputView", owner: self, options: nil).last as? InputView
            self.input?.frame = CGRectMake(0,SCREEN_HIGHT-44,SCREEN_WIDTH,44)
            self.input?.delegate = self
            self.view.addSubview(self.input!)
        }
        
         //这些可以使用懒加载方式写法
        if self.layView == nil {
            self.layView = UIView(frame: self.view.frame)
            self.layView?.backgroundColor = UIColor.grayColor()
            self.layView?.alpha = 0
            //添加手势动作
            let tap = UITapGestureRecognizer(target: self, action: Selector("tapInputView"))
            self.layView?.addGestureRecognizer(tap)
            
        }
        //插入一个View
        self.view.insertSubview(self.layView!, belowSubview: self.input!)
        self.layView?.hidden = false
        //弹出键盘
        self.input?.inputTextView?.becomeFirstResponder()
    }
    
    //遮罩层触摸点击事件
    func tapInputView(){
        self.input?.inputTextView?.resignFirstResponder()
    }
    
    func commentController(){
        let commentController = CommnentViewController()
        TitleGeneralFactory.addTitle(commentController, leftTitle: "", rightTitle: "关闭")
        commentController.bookObject = self.bookObject
        commentController.tableView?.mj_header.beginRefreshing()
        presentViewController(commentController, animated: true, completion: nil)
    }
    
    func likeBook(btn:UIButton){
        btn.enabled = false
        btn.setImage(UIImage(named: "redheart"), forState: .Normal)
        
        let query = AVQuery(className: "Love")
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.whereKey("BookObject", equalTo: bookObject)
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            if results != nil && results.count != 0{///取消点赞
                for var object in results {
                    object = (object as? AVObject)!
                    object.deleteEventually()
                }
                btn.setImage(UIImage(named: "heart"), forState: .Normal)
                
                self.bookObject?.incrementKey("loveNumber", byAmount: NSNumber(int: -1))
                self.bookObject?.saveInBackground()
                
            }else{///点赞
                let object = AVObject(className: "Love")
                object.setObject(AVUser.currentUser(), forKey: "user")
                object.setObject(self.bookObject, forKey: "BookObject")
                object.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success{
                        btn.setImage(UIImage(named: "solidheart"), forState: .Normal)
                        
                        self.bookObject?.incrementKey("loveNumber", byAmount: NSNumber(int: 1))
                        self.bookObject?.saveInBackground()
                        
                    }else{
                        ProgressHUD.showError("操作失败")
                    }
                })
            }
            btn.enabled = true
        }
    }

    
    func shareAction(){
        
    }
    
    
    /**
     *  PhotoBrowser
     */
    func photoBrowser(){
        let photoBrowser = HZPhotoBrowser()
        //设置要预览的图片张数
        photoBrowser.imageCount = 1
        //首先显示第几张图片
        photoBrowser.currentImageIndex = 0
        photoBrowser.delegate = self
        photoBrowser.show()
    }
    
    func photoBrowser(browser: HZPhotoBrowser!, placeholderImageForIndex index: Int) -> UIImage! {
        return self.BookTitleView?.cover?.image
    }
    
    func photoBrowser(browser: HZPhotoBrowser!, highQualityImageURLForIndex index: Int) -> NSURL! {
        let coverFile = bookObject!["cover"] as? AVFile
        return NSURL(string: coverFile!.url)
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
