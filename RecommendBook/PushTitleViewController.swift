//
//  PushTitleViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/24.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

//声明一个闭包
typealias PushTitleCallBack = (title: String) -> Void

class PushTitleViewController: UIViewController {
    var textFiled: UITextField!
    
    /**
     实现回调的三个方法
     1、通知
     2、代理
     3、闭包
     本页面使用闭包
    */
    var callBack: PushTitleCallBack?

    override func viewDidLoad() {
        super.viewDidLoad()
        textFiled = UITextField(frame: CGRectMake(15, 60, SCREEN_WIDTH - 30, 30))
        textFiled.borderStyle = .RoundedRect
        textFiled.placeholder = "书评标题"
        textFiled.font = UIFont(name: MAIN_FONT, size: 13)
        view.addSubview(textFiled)
        textFiled.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func close(){
        print("点击了关闭")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sure(){
        callBack?(title: textFiled.text!)
        dismissViewControllerAnimated(true, completion: nil)
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
