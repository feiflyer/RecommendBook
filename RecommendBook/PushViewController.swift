//
//  PushViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class PushViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        setNavigationBar()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
      //设置标题栏
    func setNavigationBar(){
        let navigationBar = UIView(frame: CGRectMake(0 , -20 , SCREEN_WIDTH , 65))
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

}
