//
//  UserModel.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/7/5.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit
import ObjectMapper
//class UserModel: NSObject {
//
//}

struct user:Mappable {
    var level: Int?
    var avatar: String?
    var nickName: String?
    var userId: Int?
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        level <- map["level"]
        avatar <- map["avatar"]
        nickName <- map["nickName"]
        userId <- map["userId"]
    }

}

class UserModel: Mappable {
    var user:user?
    var status: Int?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        user <- map["user"]
        status <- map["status"]
    }
}
