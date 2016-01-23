//
//  PushNewBookViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class PushNewBookViewController: UIViewController , BookTittleDelegate{
    var bookTitle: BookTitle!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        bookTitle = BookTitle(frame: CGRectMake(0, 40, SCREEN_WIDTH, 160))
        bookTitle.delegate = self
        view.addSubview(bookTitle)
        TitleGeneralFactory.addTitle(self, leftTitle: "关闭", rightTitle: "发布")
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
          dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
      BookTitleDelegate
    */
    func choiceCover() {
        print("choiceCOver")
    }

}
