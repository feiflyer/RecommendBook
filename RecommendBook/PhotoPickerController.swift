//
//  PhotoPickerController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/24.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit
protocol PhotoPickerDelegate{
    func getImageFromPicker(image: UIImage)
}

class PhotoPickerController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    var alert: UIAlertController?
    var pickerController: UIImagePickerController!
    
    var delegate: PhotoPickerDelegate?

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        //使当前的ViewController背景透明，也就是可以看到原来那层的ViewController
        modalPresentationStyle = .OverFullScreen
        view.backgroundColor = UIColor.clearColor()
        
        pickerController = UIImagePickerController()
        // true 选择照片后开启截图功能，但截出来的是正方形
        pickerController.allowsEditing = false
        pickerController.delegate = self
        
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(animated: Bool) {
        if alert == nil{
            alert = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            alert?.addAction(UIAlertAction(title: "从相册选择", style: .Default, handler: {
                (action) -> Void in
                    self.localPhoto()
            }))
            
            alert?.addAction(UIAlertAction(title: "拍照", style: .Default, handler: {
                (action) -> Void in
                     self.tackPhoto()
            }))
            
            alert?.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: {
                (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
                
            }))
            presentViewController(alert!, animated: true, completion: {
                () -> Void in
            })
        }
    }
    
    /**
     打开相机
    */
    func tackPhoto(){
        //判断没有相机
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            pickerController.sourceType = .Camera
            presentViewController(pickerController, animated: true, completion: nil)
        }else{
            let alertView = UIAlertController(title: "此机型无相机", message: nil, preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "关闭", style: .Cancel, handler:{
                (action) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
            presentViewController(alertView, animated: true, completion: {
                () -> Void in
            })
        }
        
    }
    
    /**
    打开相册
     */
    
    func localPhoto(){
        pickerController.sourceType = .PhotoLibrary
        presentViewController(pickerController, animated: true, completion: {
            () -> Void in
        })
    }
    
    //UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        pickerController.dismissViewControllerAnimated(true){
            //尾随闭包
            self.dismissViewControllerAnimated(true){
                self.delegate?.getImageFromPicker(image)
            }
        }
        
    }

   

}
