//
//  UIColor+Addtions.swift
//  SimpleSugareDemo
//
//  Created by panhongliu on 2017/5/3.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit

extension UIColor
{
    
    class func HexColor(_ hexColor: Int32 ) -> UIColor {
        let r = CGFloat(((hexColor & 0x00FF0000) >> 16)) / 255.0
        let g = CGFloat(((hexColor & 0x0000FF00) >> 8)) / 255.0
        let b = CGFloat(hexColor & 0x000000FF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}

func RGBColorWith(_ red : Int,green : Int, blue :Int) -> UIColor {
    return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1)
}

struct BaseColor {
    /**
     用于重要级段落文字信息 标题信息
     */
    static let BlackColor = UIColor.HexColor(0x000000)
    
    /**
     用于普通级段落文字 引导词
     */
    static let DarkGrayColor = UIColor.HexColor(0x343434)
    
    /**
     用于辅助次要文字信息
     */
    static let GrayColor = UIColor.HexColor(0x585858)
    
    /**
     用于提示文字
     */
    static let LightGrayColor = UIColor.HexColor(0x9c9c9c)
    
    /**
     用于边框颜色
     */
    static let BorderColor = UIColor.HexColor(0xe5e5e5)
    
    /**
     用于界面背景颜色
     */
    static let BackGroundColor = UIColor.HexColor(0xefefef)
    
    /**
     用于头部导航颜色(红色)
     */
    static let RedColor = UIColor.HexColor(0xE43941)
}
