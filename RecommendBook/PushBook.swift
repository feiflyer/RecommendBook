//
//  PushnBook.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/30.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class PushBook: NSObject {
    static func pushBookInBackgroound(dict: Dictionary<String , AnyObject> , object: AVObject){
        object.setObject(dict["BookName"], forKey: "BookName")
        object.setObject(dict["BookEditor"], forKey: "BookEditor")
        object.setObject(dict["title"], forKey: "title")
        object.setObject(dict["score"], forKey: "score")
        object.setObject(dict["type"], forKey: "type")
        object.setObject(dict["detailType"], forKey: "detailType")
        object.setObject(dict["description"], forKey: "description")
        object.setObject(AVUser.currentUser(), forKey: "user")
        let cover = dict["BookCover"] as? UIImage
        //先保存图片
        let coverFile = AVFile(data: UIImagePNGRepresentation(cover!))
        coverFile.saveInBackgroundWithBlock(){(success , error) -> Void in
            if success{
                object.setObject(coverFile, forKey: "cover")
                object.saveInBackgroundWithBlock{
                    (success , error) -> Void in
                    if success{
                        //发送通知
                        NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotification", object: nil, userInfo: ["success": "true"])
                    }else{
                        //发送通知
                        NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotification", object: nil, userInfo: ["success": "false"])
                    }
                }
            }else{
                //发送通知
                NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotification", object: nil, userInfo: ["success": "false"])
            }
        }
    }
    
}
