
//
//  SecondViewController.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/6/28.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import SDCycleScrollView
import Then
class SecondViewController: BaseViewController {

   

    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        _ = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: 50)).then({ (make) in
            
            make.text = "Then的简单用法超赞👍"
            make.font = .systemFont(ofSize: 20)
            make.textColor = .red
            make.textAlignment = .center
            self.view.addSubview(make)
            
        })
        
            let tableHeaderView = UIView().then
            {
                $0.backgroundColor =  BaseColor.BackGroundColor
                $0.frame =  CGRect(x: 0, y: 50, width: kScreenW, height: 140)
            }
        
        _ = CustomSDCycleScrollView().then { (make) in
            make.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
            make.backgroundColor = BaseColor.BackGroundColor
            
            make.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 140)
            make.backgroundColor = BaseColor.BackGroundColor
            make.imageURLStringsGroup = ["http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150806/kzp5acor6.jpg-w720","http://7fvaoh.com3.z0.glb.qiniucdn.com/image/150717/9q1g2knxa.jpg-w720"]
            
            make.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
            make.currentPageDotColor = UIColor.white // 自定义分页控件小圆标颜色
            make.pageDotColor = UIColor.white.withAlphaComponent(0.6)
            make.autoScrollTimeInterval = 3.0
            make.clearCache()
            
            tableHeaderView.addSubview(make)
  
            
            
        } //轮播
        
        self.view.addSubview(tableHeaderView)
                

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
