//
//  PushTypeViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/24.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class PushTypeViewController: UIViewController {
    var segmentController1: AKSegmentedControl?
    var segmentController2: AKSegmentedControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RGB(231, g: 231, b: 231)
        let segmentLabel = UILabel(frame: CGRectMake((SCREEN_WIDTH - 300)/2, 20, 300, 20))
        segmentLabel.font = UIFont(name: MAIN_FONT, size: 17)
        segmentLabel.text = "请选择分类"
        segmentLabel.shadowOffset = CGSizeMake(0, 1)
        segmentLabel.shadowColor = UIColor.whiteColor()
        segmentLabel.textColor = RGB(2, g: 113, b: 131)
        segmentLabel.textAlignment = .Center
        view.addSubview(segmentLabel)
        
        initSegment()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func close(){
        print("点击了关闭")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sure(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
    初始化segment
    */
    func initSegment(){
        let buttonArray1 = [
            ["image" : "leager" , "title" : "文学" , "font" : MAIN_FONT],
            ["image" : "drama masks" , "title" : "人文社科" , "font" : MAIN_FONT],
            ["image" : "aperture" , "title" : "生活" , "font" : MAIN_FONT]
        ]
        segmentController1 = AKSegmentedControl(frame: CGRectMake(10, 60, SCREEN_WIDTH - 20 , 37))
        segmentController1?.initButtonWithTitleandImage(buttonArray1)
        segmentController1?.addTarget(self, action: Selector("segmentAction:"), forControlEvents: .TouchUpInside)
        view.addSubview(segmentController1!)
        
        
        let buttonArray2 = [
            ["image" : "atom" , "title" : "经管" , "font" : MAIN_FONT],
            ["image" : "alien" , "title" : "科技" , "font" : MAIN_FONT],
            ["image" : "fire element" , "title" : "网络流行" , "font" : MAIN_FONT]
        ]
        segmentController2 = AKSegmentedControl(frame: CGRectMake(10, 110, SCREEN_WIDTH - 20 , 37))
        segmentController2?.initButtonWithTitleandImage(buttonArray2)
        segmentController2?.addTarget(self, action: Selector("segmentAction:"), forControlEvents: .TouchUpInside)
        view.addSubview(segmentController2!)

        
    }
    
   /**
    segment 的点击动作
   */
    func segmentAction(segment: AKSegmentedControl){
        let index = segment.selectedIndexes.firstIndex
        print("segment index \(index)")
        if segment == segmentController1{
            segmentController2?.setSelectedIndex(3)
        }else{
            segmentController1?.setSelectedIndex(3)
        }
    }
    

}
