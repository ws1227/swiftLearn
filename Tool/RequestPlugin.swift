//
//  RequestPluginExample.swift
//  MoyaStudy
//
//  Created by fancy on 2017/4/13.
//  Copyright © 2017年 王森. All rights reserved.
//

import Foundation
import Moya
import Result
import MBProgressHUD
import Toast
/// show or hide the loading hud

let newworkActivityPlugin = NetworkActivityPlugin { (change) -> () in
    
    
    switch(change){
        
    case .ended:
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    case .began:
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
    }
}


public final class RequestLoadingPlugin: PluginType {
    private let viewController: UIViewController
       var HUD:MBProgressHUD
       var hide:Bool
 
    init(_ vc: UIViewController,_ hideView:Bool) {
        self.viewController = vc
        self.hide = hideView
        HUD = MBProgressHUD.init()
        guard self.hide else {
            
            return
        }
        HUD = MBProgressHUD.showAdded(to: self.viewController.view, animated: true)

    }

    public func willSend(_ request: RequestType, target: TargetType) {
        print("开始请求\(self.viewController)")
       
        if self.hide  != false  {
       
        HUD.mode = MBProgressHUDMode.indeterminate
        HUD.label.text = "加载中"
        HUD.bezelView.color = UIColor.lightGray

        HUD.removeFromSuperViewOnHide = true
        HUD.backgroundView.style = .solidColor //或SolidColor
            
        }
    }
    
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        print("结束请求")
        HUD.hide(animated: true)
        
    }
    
}
struct AuthPlugin: PluginType {
    let token: String
    
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        var request = request
        request.timeoutInterval = 30
        request.addValue(token, forHTTPHeaderField: "token")
        request.addValue("ios", forHTTPHeaderField: "platform")
        request.addValue("version", forHTTPHeaderField: Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String)
        return request
    }
}






//检测token有效性
final class AccessTokenPlugin: PluginType {
    private let viewController: UIViewController
    
    init(_ vc: UIViewController) {
        self.viewController = vc
    }

    public func willSend(_ request: RequestType, target: TargetType) {}
    public func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        
        case .success(let response):
        //请求状态码
            guard  response.statusCode == 200   else {
                return
            }
            var json:Dictionary? = try! JSONSerialization.jsonObject(with: response.data,
                                                                             options:.allowFragments) as! [String: Any]
            print("请求状态码\(json?["status"] ?? "")")
            guard (json?["message"]) != nil  else {
                return
            }
            guard let codeString = json?["status"]else {return}
            //请求状态为1时候立即返回不弹出任何提示 否则提示后台返回的错误信息
            guard codeString as! Int != 1 else{return}
           self.viewController.view .makeToast( json?["message"] as! String)
            
        case .failure(let error):
            print("出错了\(error)")
            
            break
        }
    }
}
