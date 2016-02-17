//
//  AppDelegate.swift
//  RecommendBook
//
//  Created by 梁传飞 on 16/1/23.
//  Copyright © 2016年 梁传飞. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        /**
        设置LeanCloud
        */
         AVOSCloud.setApplicationId("i40Bw8oWkFemep2Rn2k9e5WX", clientKey: "MpeDsXwLTcQuuhplDjN1Hs8l")
        
        self.window = UIWindow(frame: CGRectMake(0,0,SCREEN_WIDTH , SCREEN_HIGHT))
        
        let tabBarController = UITabBarController()
        let rankNavigationController = UINavigationController(rootViewController: RankViewController())
        let searchNavigationController = UINavigationController(rootViewController: SearchViewController())
        let pushNavigationController = UINavigationController(rootViewController: PushViewController())
        let circleNavigationController = UINavigationController(rootViewController: CircleViewController())
        let moreNavigationControllrt = UINavigationController(rootViewController: MoreViewController())
        
        tabBarController.viewControllers = [rankNavigationController , searchNavigationController , pushNavigationController , circleNavigationController , moreNavigationControllrt]
        
        let rankTabBarItem = UITabBarItem(title: "排行榜", image: UIImage(named: "bio"), selectedImage: UIImage(named: "bio_red"))
        let searchTabBarItem = UITabBarItem(title: "发现", image: UIImage(named: "timer 2"), selectedImage: UIImage(named: "timer 2_red"))
        let pushTabBarItem = UITabBarItem(title: " ", image: UIImage(named: "pencil"), selectedImage: UIImage(named: "user two_red"))
        let circleTabBarItem = UITabBarItem(title: "圈子", image: UIImage(named: "users two-2"), selectedImage: UIImage(named: "uusers two-2_red"))
        let moreTabBarItem = UITabBarItem(title: "更多", image: UIImage(named: "more"), selectedImage: UIImage(named: "more_red"))
        
        rankNavigationController.tabBarItem = rankTabBarItem
        searchNavigationController.tabBarItem = searchTabBarItem
        pushNavigationController.tabBarItem = pushTabBarItem
        circleNavigationController.tabBarItem = circleTabBarItem
        moreNavigationControllrt.tabBarItem = moreTabBarItem
     
        //设置tabbarController的条目选中后的颜色
        rankNavigationController.tabBarController?.tabBar.tintColor = MAIN_RED
        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
        
        
        
        
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

