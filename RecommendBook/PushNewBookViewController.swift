//
//  PushNewBookViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class PushNewBookViewController: UIViewController , BookTittleDelegate , PhotoPickerDelegate , VPImageCropperDelegate , UITableViewDelegate , UITableViewDataSource{
    var bookTitle: BookTitle!
    var tableView: UITableView!
    var titleArray = ["标题" , "评分" , "分类" , "书评"]
    var bookTitleString = ""
    var score: LDXScore!
    
    //是否显示评分条
    var isShowScore = false
    
    var type = "文学"
    var detailType = "文学"
    var bookDescription = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        bookTitle = BookTitle(frame: CGRectMake(0, 40, SCREEN_WIDTH, 160))
        bookTitle.delegate = self
        view.addSubview(bookTitle)
        TitleGeneralFactory.addTitle(self, leftTitle: "关闭", rightTitle: "发布")
        
        tableView = UITableView(frame: CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HIGHT - 200), style: .Grouped)
        //使没有用的线消失
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        //注册cell
        tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        view.addSubview(tableView)
        
        score = LDXScore(frame: CGRectMake(100, 10, 100, 22))
        score.isSelect = true
        score.normalImg = UIImage(named: "btn_star_evaluation_normal")
        score.highlightImg = UIImage(named: "btn_star_evaluation_press")
        score.max_star = 5
        score.show_star = 5
        
        //注册一个通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("pushBookNotification:"), name: "pushBookNotification", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func close(){
        print("点击了关闭")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sure(){
        var dict = Dictionary<String , AnyObject>()
            dict["BookName"] = self.bookTitle.bookName!.text
            dict["BookEditor"] = self.bookTitle.bookEditor!.text
            dict["BookCover"] = self.bookTitle.bookCover?.currentImage
            dict["title"] = self.bookTitleString
            dict["type"] = type
            dict["score"] = score.show_star
            dict["detailType"] = detailType
            dict["description"] = description
        
        ProgressHUD.show("")
        
        PushnBook.pushBookInBackgroound(dict)

    }
    
    /**
      BookTitleDelegate
    */
    func choiceCover() {
        print("choiceCOver")
        let photoPickerController = PhotoPickerController()
        photoPickerController.delegate = self
        presentViewController(photoPickerController, animated: true, completion: nil)
    }
    
    /**
    PhotoPickerDelegate
    */
    func getImageFromPicker(image: UIImage) {
        //使用第三方库剪裁图片
        let corVc = VPImageCropperViewController(image: image, cropFrame: CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_WIDTH*1.273), limitScaleRatio: 3)
        corVc.delegate = self
        presentViewController(corVc, animated: true, completion: nil)
    }
    
    //VPImageCropperDelegate
    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
         bookTitle.bookCover?.setImage(editedImage, forState: .Normal)
          cropperViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //VPImageCropperDelegate
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
         cropperViewController.dismissViewControllerAnimated(true, completion: nil)
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        if(indexPath.row != 1){
            //设置右边小尖头
            cell.accessoryType = .DisclosureIndicator
        }
        cell.textLabel?.text = titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MAIN_FONT, size: 14)
        cell.detailTextLabel?.font = UIFont(name: MAIN_FONT, size: 14)
        
        var row = indexPath.row
        if isShowScore && row > 1{
            row--
        }
        switch row{
        case 0:
            cell.detailTextLabel?.text = bookTitleString
            break
            
        case 2:
            cell.detailTextLabel?.text = type + "->" + detailType
            break;
            
        case 4:
            
            cell.accessoryType = .None
            let commentView = UITextView(frame: CGRectMake(4,4,SCREEN_WIDTH-8,80))
            commentView.text = self.bookDescription
            commentView.font = UIFont(name: MAIN_FONT, size: 14)
            commentView.editable = false
            cell.contentView.addSubview(commentView)
            
            break;
            
            default:
            
            break
            
        }
        
        if isShowScore && indexPath.row == 2{
            cell.contentView.addSubview(score!)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if isShowScore && indexPath.row >= 5 {
            return 88
        }else if !isShowScore && indexPath.row >= 4 {
            return 88
        }else{
            return 44
        }
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //点击动作效果
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var row = indexPath.row
        if isShowScore && row >= 1{
            row -= 1
        }
        
        switch row {
        case 0:
            tableSelectTitle()
            break
            
        case 1:
            tableSelectScore()
            break
            
        case 2:
            tableSelectType()
            break
            
        case 3:
            tableSelectDescription()
            break
            
        case 4:
            
            break
            
            
        default:
            
            break
            
        }
    }
    
    /**
      选择了标题
    */
    func tableSelectTitle(){
        let pushTitleController = PushTitleViewController()
        pushTitleController.callBack = {
            (title) -> Void in
            self.bookTitleString = title
            self.tableView.reloadData()
        }
        TitleGeneralFactory.addTitle(pushTitleController)
        presentViewController(pushTitleController, animated: true, completion: nil)
    }
    
    /**
     选择了评分
     */
    func tableSelectScore(){
        
        tableView.beginUpdates()
        let tempIndexPath = [NSIndexPath(forRow: 2, inSection: 0)]
        //给tableView插入一个cell或者移除一个cell
        if isShowScore {
            titleArray.removeAtIndex(2)
            tableView.deleteRowsAtIndexPaths(tempIndexPath, withRowAnimation: .Right)
            isShowScore = false
        }else{
            titleArray.insert("", atIndex: 2)
            tableView.insertRowsAtIndexPaths(tempIndexPath, withRowAnimation: .Left)
            isShowScore = true
        }
         tableView.endUpdates()
        
//        let pushScoreController = PushScoreViewController()
//        TitleGeneralFactory.addTitle(pushScoreController)
//        presentViewController(pushScoreController, animated: true, completion: nil)
    }
    
    /**
     选择了分类
     */
    func tableSelectType(){
        let pushTypeController = PushTypeViewController()
        pushTypeController.type = self.type
        pushTypeController.detailType = self.detailType
        pushTypeController.callBack = {
            (type: String , detailType: String) -> Void in
            self.type = type
            self.detailType = detailType
            self.tableView.reloadData()
        }
        TitleGeneralFactory.addTitle(pushTypeController)
        let leftButton = pushTypeController.view.viewWithTag(1234) as! UIButton
        leftButton.setTitleColor(RGB(38, g: 82, b: 67), forState: .Normal)
        let rightButton = pushTypeController.view.viewWithTag(1235) as! UIButton
        rightButton.setTitleColor(RGB(38, g: 82, b: 67), forState: .Normal)
        
        presentViewController(pushTypeController, animated: true, completion: nil)
    }
    
    /**
     选择了书评
     */
    func tableSelectDescription(){
        let pushDescriptionController = PushDescriptionViewController()
        pushDescriptionController.bookDescription = self.bookDescription
        pushDescriptionController.callBack = {
            (description) -> Void in
            self.bookDescription = description
            if self.titleArray.last == ""{
                self.titleArray.removeLast()
            }
            
            if description != ""{
                self.titleArray.append("")
                self.tableView.reloadData()
            }
            
        }
        TitleGeneralFactory.addTitle(pushDescriptionController)
        presentViewController(pushDescriptionController, animated: true, completion: nil)
    }
    
    //通知
    func pushBookNotification(notification: NSNotification){
        let dict = notification.userInfo
        if String(dict!["success"]!) == "true"{
            ProgressHUD.showSuccess("上传成功")
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            ProgressHUD.showError("上传失败")
        }
        
    }

    //析构函数
    deinit{
        print("deinit----")
        //移除通知
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }


}
