//
//  config.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import Foundation

//全局常量文件，相当oc中的宏

//设备常量
let SCREEN_WIDTH = UIScreen.mainScreen().bounds.size.width
let SCREEN_HIGHT = UIScreen.mainScreen().bounds.size.height

//颜色
let MAIN_RED = UIColor(colorLiteralRed: 235/255, green: 114/255, blue: 118/255, alpha: 1)
func RGB(r: CGFloat , g: CGFloat , b: CGFloat) -> UIColor{
    return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
}

//字体
let MAIN_FONT = "Bauhaus ITC"