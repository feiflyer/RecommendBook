
//
//  PushDescriptionViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/24.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

typealias DescriptionCloser = (description: String) -> Void

class PushDescriptionViewController: UIViewController {
    
    var bookDescription = ""
    var textView: JVFloatLabeledTextView!
    var callBack: DescriptionCloser?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        textView = JVFloatLabeledTextView(frame: CGRectMake(8, 58, SCREEN_WIDTH - 16, SCREEN_HIGHT-58-8))
        view.addSubview(textView)
        textView.placeholder = "    你可以在这里撰写想写的评价、吐槽、介绍～～"
        textView.font = UIFont(name: MAIN_FONT, size: 15)
        view.tintColor = UIColor.grayColor()
        textView.text = bookDescription
        textView.becomeFirstResponder()
        
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func close(){
        print("点击了关闭")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sure(){
         callBack?(description: textView.text)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     键盘消失
    */
    func keyboardWillHideNotification(notification: NSNotification){
        textView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    /**
     键盘出现
     */
    func keyboardWillShowNotification(notification: NSNotification){
        let rect = XKeyBoard.returnKeyBoardWindow(notification)
        textView.contentInset = UIEdgeInsetsMake(0, 0, rect.height, 0)
    }

}
