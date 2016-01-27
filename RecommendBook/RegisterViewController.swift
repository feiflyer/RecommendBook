//
//  RegisterViewController.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/26.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var eMail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func register(sender: AnyObject) {
        let user = AVUser()
        user.username = self.userName.text
        user.password = self.passWord.text
        user.email = self.eMail.text
        user.signUpInBackgroundWithBlock{ (success, error) -> Void in
            if success {
                ProgressHUD.showSuccess("注册成功，请验证邮箱")
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    
                })
            }else{
                if error.code == 125 {
                    ProgressHUD.showError("邮箱不合法")
                }else if error.code == 203 {
                    ProgressHUD.showError("该邮箱已注册")
                }else if error.code == 202 {
                    ProgressHUD.showError("用户名已存在")
                }else{
                    ProgressHUD.showError("注册失败")
                }
                
            }
        }
    }

    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
     *  注册键盘出现和消失
     */
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.topLayout.constant = 8
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.topLayout.constant = -200
            self.view.layoutIfNeeded()
        }
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
