//
//  HomeDataModel.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/7/6.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit
import ObjectMapper

class PagingModel: Mappable {
    var next_url :String?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        next_url <- map["next_url"]

    }
    
}

class BannersModle: Mappable {
    var image_url :String?
    var target_id :Int?

    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        image_url <- map["image_url"]
        target_id <- map["target_id"]

    }
    
}
class DanTangDataModel: Mappable {
    
    var items :[HomeDataModel]?
    var paging :PagingModel?
    var banners :[BannersModle]?

    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        items <- map["items"]
        paging <- map["paging"]
        banners <- map["banners"]


    }

}

class HomeModel: Mappable {

    var code :Int?
    var data :DanTangDataModel?

    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        data <- map["data"]

    }
}


class HomeDataModel: Mappable {
    var content_url: String?
    var cover_image_url: String?
    var created_at: String?
    var id: String?
    var liked: String?
    var likes_count: Int = 0
    var share_msg: String?
    var published_at: String?
    var short_title: String?
    var status: String?
    var type: String?
    var title: String?
    var template: String?
    var updated_at: String?
    var url: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        content_url <- map["content_url"]
        cover_image_url <- map["cover_image_url"]
        created_at <- map["created_at"]
        id <- map["id"]
        liked <- map["liked"]
        likes_count <- map["likes_count"]
        share_msg <- map["share_msg"]
        published_at <- map["published_at"]
        short_title <- map["short_title"]
        status <- map["status"]
        type <- map["type"]
        title <- map["title"]
        template <- map["template"]
        title <- map["title"]
        updated_at <- map["updated_at"]
        url <- map["url"]

    }

}
class BannerDataModel: Mappable
{
    var channel: String?
    var id: String?
    var image_url: String?
    var order: String?
    var status: String?
    var type: String?
    var target_id: String?
    var target_url: String?
    var target: TargetDataModel!
    required init?(map: Map) {
  
    }
    
    func mapping(map: Map) {
        channel <- map["channel"]
        id <- map["id"]
        image_url <- map["image_url"]
        order <- map["order"]
        status <- map["status"]
        type <- map["type"]
        target_id <- map["target_id"]
        target_url <- map["target_url"]
        target <- map["target"]

    }
    

}

class TargetDataModel: Mappable
{
    var id: String?
    var banner_image_url: String?
    var cover_image_url: String?
    var status: String?
    var created_at: String?
    var posts_count: String?
    var subtitle: String?
    var title: String?
    var updated_at: String?
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        banner_image_url <- map["banner_image_url"]
        cover_image_url <- map["cover_image_url"]
        status <- map["status"]
        created_at <- map["created_at"]
        posts_count <- map["posts_count"]
        subtitle <- map["subtitle"]
        posts_count <- map["posts_count"]
        title <- map["title"]
        updated_at <- map["updated_at"]


}
}


