//
//  UIScrollView+ReFresh.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/7/6.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit
import MJRefresh


extension UIScrollView
{
    
    

    func headerRefresh(block: @escaping () -> ()) -> (){
      
      self.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
        block()
        
        })
      
 
    }
    func footerRefresh(block: @escaping () -> ()) -> (){
        
        self.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            block()
   
            
        })
        
        
    }
    
    func endrefresh(){
        
        self.mj_footer.endRefreshing()
        self.mj_header.endRefreshing()
        
        
        
    }
    
    
}

