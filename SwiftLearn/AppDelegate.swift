//
//  AppDelegate.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/6/28.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit
import Kingfisher
import FLEX
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        PlusButtonSubclass.register()
       self.listenNetwork()
        
        let cache = KingfisherManager.shared.cache
        cache.clearDiskCache()
        // 设置硬盘最大缓存100M ，默认无限
        cache.maxDiskCacheSize = 100 * 1024 * 1024
        // 设置硬盘最大保存3天 ， 默认1周
        cache.maxCachePeriodInSecond = 60 * 60 * 24 * 4
        // 获取硬盘缓存的大小
        cache.calculateDiskCacheSize { (size) -> () in
        //删缓存
//        cache.clearDiskCache()
//        CustomSDCycleScrollView.clearImagesCache()

            
        }
        
        
        FLEXManager.shared().showExplorer()
   

        application.statusBarStyle = UIStatusBarStyle.lightContent
        UINavigationBar.appearance().barTintColor = UIColor.white
//        UINavigationBar.appearance().tintColor = UIColor.white
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.window = UIWindow()
        self.window!.frame = UIScreen.main.bounds
        self.window!.rootViewController = BaseTabBarController()
        self.window!.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

