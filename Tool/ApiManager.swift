//
//  ApiManager.swift
//  ZhiHu+RxSwift
//
//  Created by like on 2017/1/28.
//  Copyright © 2017年 王森. All rights reserved.
//

import Foundation
import Moya




let ApiManagerProvider = RxMoyaProvider<ApiManager>(endpointClosure: endpointMapping,plugins:[])

private func endpointMapping<Target: TargetType>(target: Target) -> Endpoint<Target> {
    
    
        print("请求连接：\(target.baseURL)\(target.path) \n方法：\(target.method)\n参数：\(String(describing: target.parameters)) ")
 

    return MoyaProvider.defaultEndpointMapping(for: target)
}

enum ApiManager {
    case getDantangList(String)
    case getNewsList
    case getMoreNews(String)
    case getThemeList
    case getThemeDesc(Int)
    case getNewsDesc(Int)
    case Create(title: String, body: String, userId: Int)
    case Login(phone:String,password:String)
    case Banner(String)
}

extension ApiManager: TargetType {
    /// The target's base `URL`.
    var baseURL: URL {
        switch self {
        case .Create(_,_,_):
        return URL.init(string: "http://jsonplaceholder.typicode.com/")!
        case .getDantangList,.Banner:
            return URL.init(string: "http://api.dantangapp.com/")!
        case .Login:
            return URL.init(string: "https://api.grtstar.cn")!
        default:
        return URL.init(string: "http://news-at.zhihu.com/api/")!
        }
        }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .getDantangList(let page):
            return "v1/channels/\(page)/items"
        case .getNewsList:
            return "4/news/latest"
        case .getMoreNews(let date):
            return "4/news/before/" + date
        case .getThemeList:
            return "4/themes"
        case .getThemeDesc(let id):
            return "4/theme/\(id)"
        case .getNewsDesc(let id):
            return "4/news/\(id)"
        case .Create(_, _, _):
            return "posts"
        case .Login:
            return "/rest/user/certificate"
        case .Banner:
            return "v1/banners"

        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        switch self {

        case .Create(_, _, _):
        return .post
        case .Login:
        return .post
        default:
        return .get
        }

    }
    
    /// The parameters to be incoded in the request.
    var parameters: [String: Any]? {
        switch self {
        case .Create(let title, let body, let userId):
            return ["title": title, "body": body, "userId": userId]
            
        case .Login(let number, let passwords):
        return ["mobile" : number, "password" :  passwords,"deviceId": "12121312323"]
        case .Banner(let strin):
            return ["channel" :strin]
            
        default:
            return nil

        }
    }
    
    /// The method used for parameter encoding.
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data {
        
        switch self {
//        case .Show:
//            return "[{\"userId\": \"1\", \"Title\": \"Title String\", \"Body\": \"Body String\"}]".data(using: String.Encoding.utf8)!
        case .Create(_, _, _):
            return "Create post successfully".data(using: String.Encoding.utf8)!
        default:
            return "".data(using: String.Encoding.utf8)!

        }
    }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        return .request
    }
    
    /// Whether or not to perform Alamofire validation. Defaults to `false`.
    var validate: Bool {
        return false
    }
}
