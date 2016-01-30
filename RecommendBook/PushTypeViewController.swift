//
//  PushTypeViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/24.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

//声明一个闭包
typealias PushTypeCloser = (String , String) -> Void

class PushTypeViewController: UIViewController , IGLDropDownMenuDelegate{
    
    var callBack: PushTypeCloser?
    
    var literatureArray1:Array<NSDictionary> = []
    var literatureArray2:Array<NSDictionary> = []
    
    
    var humanitiesArray1:Array<NSDictionary> = []
    var humanitiesArray2:Array<NSDictionary> = []
    
    
    var livelihoodArray1:Array<NSDictionary> = []
    var livelihoodArray2:Array<NSDictionary> = []
    
    
    var economiesArray1:Array<NSDictionary> = []
    var economiesArray2:Array<NSDictionary> = []
    
    
    var technologyArray1:Array<NSDictionary> = []
    var technologyArray2:Array<NSDictionary> = []
    
    var NetworkArray1:Array<NSDictionary> = []
    var NetworkArray2:Array<NSDictionary> = []
    
    var type = "文学"
    var detailType = "文学"
    
    var dropDownMenu1:IGLDropDownMenu?
    var dropDownMenu2:IGLDropDownMenu?

    
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
        
        initDropArray()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func close(){
        print("点击了关闭")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sure(){
        if callBack != nil{
           callBack?(self.type , self.detailType)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     init Array
     */
    func initDropArray(){
        
        self.literatureArray1 = [
            ["title":"小说"],
            ["title":"漫画"],
            ["title":"青春文学"],
            ["title":"随笔"],
            ["title":"现当代诗"],
            ["title":"戏剧"],
        ];
        self.literatureArray2 = [
            ["title":"传记"],
            ["title":"古诗词"],
            ["title":"外国诗歌"],
            ["title":"艺术"],
            ["title":"摄影"],
        ];
        self.humanitiesArray1 = [
            ["title":"历史"],
            ["title":"文化"],
            ["title":"古籍"],
            ["title":"心理学"],
            ["title":"哲学/宗教"],
            ["title":"政治/军事"],
        ];
        self.humanitiesArray2 = [
            ["title":"社会科学"],
            ["title":"法律"],
        ];
        self.livelihoodArray1 = [
            ["title":"休闲/爱好"],
            ["title":"孕产/胎教"],
            ["title":"烹饪/美食"],
            ["title":"时尚/美妆"],
            ["title":"旅游/地图"],
            ["title":"家庭/家居"],
        ];
        self.livelihoodArray2 = [
            ["title":"亲子/家教"],
            ["title":"两性关系"],
            ["title":"育儿/早教"],
            ["title":"保健/养生"],
            ["title":"体育/运动"],
            ["title":"手工/DIY"],
        ];
        self.economiesArray1  = [
            ["title":"管理"],
            ["title":"投资"],
            ["title":"理财"],
            ["title":"经济"],
        ];
        self.economiesArray2  = [
            ["title":"没有更多了"],
        ];
        self.technologyArray1 =  [
            ["title":"科普读物"],
            ["title":"建筑"],
            ["title":"医学"],
            ["title":"计算机/网络"],
        ];
        self.technologyArray2 = [
            ["title":"农业/林业"],
            ["title":"自然科学"],
            ["title":"工业技术"],
        ];
        self.NetworkArray1 =    [
            ["title":"玄幻/奇幻"],
            ["title":"武侠/仙侠"],
            ["title":"都市/职业"],
            ["title":"历史/军事"],
        ];
        self.NetworkArray2 =    [
            ["title":"游戏/竞技"],
            ["title":"科幻/灵异"],
            ["title":"言情"],
        ];
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
        segmentController1?.addTarget(self, action: Selector("segmentAction:"), forControlEvents: .ValueChanged)
        view.addSubview(segmentController1!)
        
        
        let buttonArray2 = [
            ["image" : "atom" , "title" : "经管" , "font" : MAIN_FONT],
            ["image" : "alien" , "title" : "科技" , "font" : MAIN_FONT],
            ["image" : "fire element" , "title" : "网络流行" , "font" : MAIN_FONT]
        ]
        segmentController2 = AKSegmentedControl(frame: CGRectMake(10, 110, SCREEN_WIDTH - 20 , 37))
        segmentController2?.initButtonWithTitleandImage(buttonArray2)
        segmentController2?.addTarget(self, action: Selector("segmentAction:"), forControlEvents: .ValueChanged)
        view.addSubview(segmentController2!)

        
    }
    
   /**
    segment 的点击动作
   */
    func segmentAction(segment: AKSegmentedControl){
        var index = segment.selectedIndexes.firstIndex
        type = (segment.buttonsArray[index] as! UIButton as UIButton).currentTitle!
        print("segment index \(index)")
        if segment == segmentController1{
            segmentController2?.setSelectedIndex(3)
        }else{
            segmentController1?.setSelectedIndex(3)
            index += 3
        }
        if (dropDownMenu1 != nil){
            dropDownMenu1!.resetParams()
        }
        if dropDownMenu2 != nil{
            dropDownMenu2!.resetParams()
        }
        
        switch index{
        case 0:
            createDropMenu(literatureArray1, array2: literatureArray2)
            break
            
        case 1:
             createDropMenu(humanitiesArray1, array2: humanitiesArray2)
            break
            
        case 2:
             createDropMenu(livelihoodArray1, array2: livelihoodArray2)
            break
            
        case 3:
             createDropMenu(economiesArray1, array2: economiesArray2)
            break
            
        case 4:
             createDropMenu(technologyArray1, array2: technologyArray2)
            break
            
        case 5:
             createDropMenu(NetworkArray1, array2: NetworkArray2)
            break
            
        default:
            
            break
        }
    }
    
    /**
    初始化dropDownMenu  Swift风格
    */
    func createDropMenu1(array1: Array<Dictionary<String , String>> , array2: Array<Dictionary<String , String>>)   {
        var dropDownItem1 = Array<IGLDropDownItem>()
        for var i = 0;i<array1.count;i++ {
            let dict = array1[i]
            let item = IGLDropDownItem()
            item.text = dict["title"]
            dropDownItem1.append(item)
        }
        
        var dropDownItem2 = [IGLDropDownItem]()
        for var i = 0;i<array2.count;i++ {
            let dict = array2[i]
            let item = IGLDropDownItem()
            item.text = dict["title"]
            dropDownItem2.append(item)
        }
    }

    
    /**
     初始化dropDownMenu
     */
    func createDropMenu(array1: Array<NSDictionary> , array2: Array<NSDictionary>){
        let dropDownItem1 = NSMutableArray()
        for var i = 0;i<array1.count;i++ {
            let dict = array1[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as? String
            dropDownItem1.addObject(item)
        }
        
        let dropDownItem2 = NSMutableArray()
        for var i = 0;i<array2.count;i++ {
            let dict = array2[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as? String
            dropDownItem2.addObject(item)
        }
        
        dropDownMenu1?.removeFromSuperview()
        dropDownMenu1 = IGLDropDownMenu()
        dropDownMenu1?.menuText = "点我，展开详细列表"
        //使字体自动变小，以适应超出控件大小的内容
        dropDownMenu1?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        dropDownMenu1?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        dropDownMenu1?.paddingLeft = 15
        dropDownMenu1?.delegate = self
        dropDownMenu1?.type = .Stack
        dropDownMenu1?.itemAnimationDelay = 0.1
        dropDownMenu1?.gutterY = 5
        dropDownMenu1?.dropDownItems = dropDownItem1 as [AnyObject]
        dropDownMenu1?.frame = CGRectMake(20, 150, SCREEN_WIDTH/2-30, (SCREEN_HIGHT-200)/7)
        view.addSubview(self.dropDownMenu1!)
        dropDownMenu1?.reloadView()
        
        
        dropDownMenu2?.removeFromSuperview()
        dropDownMenu2 = IGLDropDownMenu()
        dropDownMenu2?.menuText = "点我，展开详细列表"
        dropDownMenu2?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        dropDownMenu2?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        dropDownMenu2?.paddingLeft = 15
        dropDownMenu2?.delegate = self
        dropDownMenu2?.type = .Stack
        dropDownMenu2?.itemAnimationDelay = 0.1
        dropDownMenu2?.gutterY = 5
        dropDownMenu2?.dropDownItems = dropDownItem2 as [AnyObject]
        dropDownMenu2?.frame = CGRectMake(SCREEN_WIDTH/2+10, 150, SCREEN_WIDTH/2-30, (SCREEN_HIGHT-200)/7)
        view.addSubview(self.dropDownMenu2!)
        dropDownMenu2?.reloadView()
    }
    
    /**
     *  IGLDropDownMenuDelegate
     */
    func dropDownMenu(dropDownMenu: IGLDropDownMenu!, selectedItemAtIndex index: Int) {
        if dropDownMenu == self.dropDownMenu1 {
            let item = self.dropDownMenu1?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu2?.menuButton.text = self.detailType
        }else{
            let item = self.dropDownMenu2?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu1?.menuButton.text = self.detailType
        }
    }

}
