//
//  RequestExampleViewController.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/7/6.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit

class RequestExampleViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewModel  = ViewModel(self)

                viewModel.login(phone: "15617877692" , password: "11111")
                    .subscribe(onNext: { (userModel: UserModel) in
                        //do something with posts
                        print(userModel.user?.nickName ?? "")
        
                                  })
                    .addDisposableTo(dispose)
        
        
        
        
        
                viewModel.login(phone: "15617877692" , password: "11111").subscribe ({event in
                    switch event {
                    case .next(let response):
        
                        let userMdoel:UserModel = response
                        print( "成功：\(String(describing:  userMdoel.user?.nickName))");
        
                        break
                    // do something with the data
                    case .error(let error):
                        print( "错误：\( error)");
        
                        break
                    default:
                        break
        
                        // handle the error
        
                 }
                    })
                    .addDisposableTo(dispose)
        
        
        
                viewModel.createPost(title: "Title 1", body: "Body 1", userId: 1)
                    .subscribe(onNext: { (post: Post) in
                        //do something with post
                        print(post.title ?? "99000")
                        
                        
                    })
                    
                    .addDisposableTo(dispose)

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
