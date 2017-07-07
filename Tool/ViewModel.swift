//
//  ViewModel.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/7/1.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Moya
import Alamofire



public func defaultAlamofireManager() -> Manager {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders

    let policies: [String: ServerTrustPolicy] = [
       
        "ap.grtstar.cn": .disableEvaluation
    ]
    let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
    
    manager.startRequestsImmediately = false
    return manager
}


private func endpointMapping<Target: TargetType>(target: Target) -> Endpoint<Target> {
    
    
    print("请求连接：\(target.baseURL)\(target.path) \n方法：\(target.method)\n参数：\(String(describing: target.parameters)) ")
    
    
    return MoyaProvider.defaultEndpointMapping(for: target)
}


public final  class ViewModel: NSObject {
    
    private let viewController: UIViewController
    let provider :RxMoyaProvider<ApiManager>
    
    
    init(_ vc: UIViewController) {
        self.viewController = vc
        provider = RxMoyaProvider<ApiManager>(endpointClosure: endpointMapping,manager:defaultAlamofireManager(),plugins:[RequestLoadingPlugin(self.viewController,true),AccessTokenPlugin( self.viewController), NetworkLoggerPlugin(verbose: true),newworkActivityPlugin,AuthPlugin(token: "暂时为空")
])
        

    }

    func getDantangList(_ page:String) -> Observable<HomeModel> {
        return provider.request(.getDantangList(page))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            
//            .debug() // 打印请求发送中的调试信息
//             .parseServerError()
            .mapObject(type: HomeModel.self)

    }
    
    func createPost(title: String, body: String, userId: Int) -> Observable<Post> {
        return provider.request(.Create(title: title, body: body, userId: userId))
            .mapJSON()
            .debug() // 打印请求发送中的调试信息
//            .parseServerError()

            .mapObject(type: Post.self)
        
    }
    
    func login(phone: String, password:String) -> Observable<UserModel> {
        return provider.request(.Login(phone: phone, password: password))
            .mapJSON()
            .debug() // 打印请求发送中的调试信息
            //            .parseServerError()
            
            .mapObject(type: UserModel.self)
    }

    func banner(channel: String) -> Observable<HomeModel> {
        return provider.request(.Banner(channel))
            .mapJSON()
            .debug() // 打印请求发送中的调试信息
            //            .parseServerError()
            
            .mapObject(type: HomeModel.self)
    }

   
    

    
}
