//
//  CustomSDCycleScrollView.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/7/6.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit
import SDCycleScrollView
import Kingfisher


class CustomSDCycleScrollView: SDCycleScrollView  {

    //因为之前库里边用的是SDWebImageView 缓存的图片 现在 换了Swift版本的Kingfisher所以 无奈修改了原库的方法 重写了下
    open override func imageView(_ imageView: UIImageView!, url: URL!) -> UIImageView! {
        let imageView: UIImageView? = imageView
      imageView?.kf.setImage(with: url,placeholder:UIImage.init(named: "tab_5th_h"))

        return imageView

        
    }
    //重写oc代码 删除缓存
      override class func clearImagesCache()
      {
        let cache = KingfisherManager.shared.cache

        // 获取硬盘缓存的大小
        cache.calculateDiskCacheSize { (size) -> () in
            print("磁盘缓存大小： \(size) bytes  下边的方法删了缓存")
            cache.clearDiskCache()

        }
       }
   
  
    

  
}



