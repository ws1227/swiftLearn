//
//  NewsDetailModel.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/7/1.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit
import ObjectMapper
struct LaunchModelImg: Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    init?(map: Map) {
        
    }

    var url: String?
    var text: String?
    var start_time : Int?
    var impression_tracks: [String]?

    mutating func mapping(map: Map) {
        url <- map["url"]
        text <- map["text"]
        start_time <- map["start_time"]
        impression_tracks <- map["impression_tracks"]
    }
}

struct listModel: Mappable {
    var date: String?
    var stories: [NewsDetailModel]?
    var top_stories: [NewsDetailModel]?
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        date <- map["date"]
        stories <- map["stories"]
        top_stories <- map["top_stories"]
    }

    
}

class NewsDetailModel: Mappable {
    var body: String?
    var ga_prefix: String?
    var id: Int?
    var image: String?
    var image_source: String?
    var share_url: String?
    var title: String?
    var type: Int?
    var images: [String]?
    var css: [String]?
    var js: [String]?


    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        body <- map["body"]
        ga_prefix <- map["ga_prefix"]
        id <- map["id"]
        image <- map["image"]
        image_source <- map["image_source"]
        title <- map["title"]
        type <- map["type"]
        title <- map["creatives"]
        images <- map["images"]
        css <- map["css"]
        js <- map["js"]

    }
}
