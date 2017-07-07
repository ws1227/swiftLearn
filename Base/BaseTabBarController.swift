//
//  BaseTabBarController.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/6/28.
//  Copyright © 2017年 wangsen. All rights reserved.
//


import UIKit
import CYLTabBarController
class BaseTabBarController: CYLTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

      UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.blue], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.red], for: .selected)
        self.tabBarItem.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 18)], for: .normal)
        
        
        let controllerName = ["FirstViewController","SecondViewController","ThirdViewController","FirstViewController"]
        // titles of tabbar
        let titles = ["首页","人脉","消息","我的"]
        // selected images of tabbar
        let selectedImages = ["tab_5th_h","tab_2nd_h","tab_4th_h","tab_3rd_h"]
        // unselected images of tabbar
        let images = ["tab_5th_n","tab_2nd_n","tab_4th_n","tab_3rd_n"]
        
        

        var tabBarItemsAttributes = [[AnyHashable: Any]]()
        var viewControllers = [UIViewController]()

        for i in 0 ..< titles.count {
            let dict: [AnyHashable: Any] = [
                CYLTabBarItemTitle: titles[i],
                CYLTabBarItemImage: images[i],
                CYLTabBarItemSelectedImage: selectedImages[i]
            ]
            let cls:AnyClass?  = NSClassFromString(String("SwiftLearn." + controllerName[i]))
            
            let viewControllerCls = cls as! UIViewController.Type

            let vc = viewControllerCls.init()
            
            let nav = BaseNavigationViewController.init(rootViewController: vc)
            
            
            tabBarItemsAttributes.append(dict)
            
            viewControllers.append(nav)
        }
        
        self.tabBarItemsAttributes = tabBarItemsAttributes
        self.viewControllers = viewControllers
    }

    
        // Do any additional setup after loading the view.
   

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

class PlusButtonSubclass : CYLPlusButton,CYLPlusButtonSubclassing{
    class func plusButton() -> Any! {
        let button:PlusButtonSubclass =  PlusButtonSubclass()
        button.setImage(UIImage(named: "icon_middle_add"), for: UIControlState())
        //        button.backgroundColor = UIColor.yellowColor()
        button.setTitle("发布", for: UIControlState())
        button.setTitle("选中", for: UIControlState.selected)
        button.setTitleColor(UIColor.red, for: UIControlState())
        button.setTitleColor(UIColor.green, for: UIControlState.selected)
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 9.5)
        button.titleLabel!.textAlignment = NSTextAlignment.center;
        button.adjustsImageWhenHighlighted = false;
        // if you use `+plusChildViewController` , do not addTarget to plusButton.
        //    button.addTarget(button, action: #selector(PlusButtonSubclass.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        // set button frame
        //    button.frame.size.width = 100
        //    button.frame.size.height = 100
        button.sizeToFit()
        return button
    }
    
    // button click action
    
    //  func buttonClicked(sender:CYLPlusButton) {
    //    sender.selected = !sender.selected
    //    print("hello middle")
    //  }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // tabbar UI layout setup
        let imageViewEdgeWidth   = self.bounds.size.width * 0.7
        let imageViewEdgeHeight = imageViewEdgeWidth * 0.9
        
        let centerOfView    = self.bounds.size.width * 0.5
        let labelLineHeight = self.titleLabel!.font.lineHeight
        let verticalMargin = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight ) * 0.5
        
        let centerOfImageView = verticalMargin + imageViewEdgeHeight * 0.5
        let centerOfTitleLabel = imageViewEdgeHeight + verticalMargin * 2  + labelLineHeight * 0.5 + 5
        
        //imageView position layout
        self.imageView!.bounds = CGRect(x: 0, y: 0, width: imageViewEdgeWidth, height: imageViewEdgeHeight)
        self.imageView!.center = CGPoint(x: centerOfView, y: centerOfImageView)
        
        //title position layout
        self.titleLabel!.bounds = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: labelLineHeight)
        self.titleLabel!.center = CGPoint(x: centerOfView, y: centerOfTitleLabel)
    }
    
    static func plusChildViewController() -> UIViewController! {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.red
        return viewController
    }
    
    static func indexOfPlusButtonInTabBar() -> UInt {
        return 2
    }
    
    static func multiplier(ofTabBarHeight tabBarHeight: CGFloat) -> CGFloat {
        return 0.3
 }
}

