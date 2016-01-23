//
//  BookTitle.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

@objc protocol BookTittleDelegate{
    optional func choiceCover()
}
 // 协议之前加上@objc表示该协议是Object C协议，可以使用可选实现


class BookTitle: UIView {

    var bookCover: UIButton?
    var bookName: JVFloatLabeledTextField?
    var bookEditor: JVFloatLabeledTextField?
    var delegate: BookTittleDelegate?
    
   override init(frame: CGRect) {
        super.init(frame: frame)
    bookCover = UIButton(frame: CGRectMake(10, 8, 110, 141))
    bookCover?.setImage(UIImage(named: "Cover"), forState: .Normal)
    bookCover?.addTarget(self, action: Selector("coverClick"), forControlEvents: .TouchUpInside)
    
    bookName = JVFloatLabeledTextField(frame: CGRectMake(128, 8+40, SCREEN_WIDTH-128-15, 30))
    bookName?.placeholder = "书名"
    bookName?.font = UIFont(name: MAIN_FONT, size: 14)
    bookName?.floatingLabel.font = UIFont(name: MAIN_FONT, size: 14)
    
    bookEditor = JVFloatLabeledTextField(frame: CGRectMake(128, 8+90, SCREEN_WIDTH-128-15, 30))
    bookEditor?.placeholder = "作者"
    bookEditor?.floatingLabel.font = UIFont(name: MAIN_FONT, size: 14)
    bookEditor?.font = UIFont(name: MAIN_FONT, size: 14)
    
    self.addSubview(bookCover!)
    addSubview(bookName!)
    addSubview(bookEditor!)
    
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not implemted")
    }
    
    func coverClick(){
        delegate?.choiceCover!()
    }
    
    

}
