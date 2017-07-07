//
//  Post.swift
//  RxSwiftMoya
//
//  Created by Chao Li on 9/21/16.
//  Copyright © 2016 ERStone. All rights reserved.
//

import Foundation
import ObjectMapper

class Post: Mappable {
    var id: Int?
    var title: String?
    var body: String?
    var userId: Int?
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        body <- map["body"]
        userId <- map["userId"]
    }
}
