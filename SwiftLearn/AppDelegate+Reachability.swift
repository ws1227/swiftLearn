//
//  AppDelegate+Reachability.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/7/7.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit
import Alamofire

extension AppDelegate
{
    //监听网络状态
    func  listenNetwork(){
        let manager = NetworkReachabilityManager(host: "www.baidu.com")
        
        manager?.listener = { status in
            
            switch status {
            case .unknown:
                break
            case.notReachable:
                break
            case .reachable:
                
                break
                
            }

            print("Network Status Changed: \(status)")
        }
        
        manager?.startListening()
        
        
    }
    
}
