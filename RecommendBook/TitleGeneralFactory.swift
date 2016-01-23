//
//  TitleGeneralFactory.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class TitleGeneralFactory: NSObject {

    static func addTitle(target: UIViewController , leftTitle: String = "关闭" , rightTitle: String = "确定"){
        let leftButton = UIButton(frame: CGRectMake(10, 20, 40, 20))
        leftButton.setTitle(leftTitle, forState: .Normal)
        leftButton.contentHorizontalAlignment = .Left
        leftButton.titleLabel?.font = UIFont(name: MAIN_FONT, size: 15)
        leftButton.setTitleColor(MAIN_RED, forState: .Normal)
        leftButton.addTarget(target, action: Selector("close"), forControlEvents: .TouchUpInside)
        target.view.addSubview(leftButton)
        
        let rightButton = UIButton(frame: CGRectMake(SCREEN_WIDTH - 50, 20, 40, 20))
        rightButton.setTitle(rightTitle, forState: .Normal)
        rightButton.contentHorizontalAlignment = .Left
        rightButton.titleLabel?.font = UIFont(name: MAIN_FONT, size: 15)
        rightButton.setTitleColor(MAIN_RED, forState: .Normal)
        //危险写法，如果传进来的ViewCOntroller中没有实现sure()方法，则会崩溃
        rightButton.addTarget(target, action: Selector("sure"), forControlEvents: .TouchUpInside)
        target.view.addSubview(rightButton)
        
        
        
        
    }
}
