//
//  FirstViewController.swift
//  SwiftLearn
//
//  Created by panhongliu on 2017/6/28.
//  Copyright © 2017年 wangsen. All rights reserved.
//

import UIKit
import RxSwift
import SDCycleScrollView
import MJRefresh

let homeCell = "homeCell"

let dispose = DisposeBag()

class FirstViewController: BaseViewController {
    fileprivate var circleView = CustomSDCycleScrollView() //轮播
    var tableView = UITableView()
    fileprivate var listArray = [HomeDataModel?]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        self.loadData()
        
        
        
        self.navigationItem.title = "首页"
        

    
    }
    
    func  loadData (){
        let viewModel  = ViewModel(self)

        viewModel.getDantangList("1")
            .subscribe(onNext: { (posts: HomeModel) in
                //do something with posts
                print(posts.data?.items?.count ?? "")
                self.listArray = (posts.data?.items)!
                self.tableView.reloadData()
                
            })
            .addDisposableTo(dispose)
        viewModel.banner(channel: "iOS")
            .subscribe(onNext: { (posts: HomeModel) in
                //do something with posts
                var imageURLStringsGroup = [String]()
                for  Model  in (posts.data?.banners)!
                {
                    imageURLStringsGroup.append(Model.image_url!)
                }
                self.circleView.imageURLStringsGroup = imageURLStringsGroup
                
                self.tableView.reloadData()
                self.tableView.endrefresh()
                
            
            })
            .addDisposableTo(dispose)
        

    }
    
    fileprivate func setupTableView()
        
    {
        tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: kScreenW, height: kScreenH-64-49), style: .plain)
        tableView.backgroundColor = BaseColor.BackGroundColor
        tableView.rowHeight = 150
        tableView.separatorStyle = .none
        tableView.delegate = self;
        tableView.dataSource = self
        tableView.scrollIndicatorInsets = tableView.contentInset
        let nib = UINib(nibName: "HomeTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCell)
      
       
        weak var weakself = self
        //上拉刷新

        tableView.headerRefresh {
            weakself?.loadData()

        }
        //下拉加载

        tableView.footerRefresh{
            weakself?.loadData()

        }
        

             view.addSubview(tableView)
        
            let tableHeaderView = UIView(frame: CGRect(x: 0,y: 0,width: kScreenW,height: 148))
            tableHeaderView.backgroundColor = BaseColor.BackGroundColor
            
            circleView.frame = CGRect(x: 0, y: 0, width: kScreenW, height: 140)
            circleView.backgroundColor = BaseColor.BackGroundColor
            circleView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter
            circleView.currentPageDotColor = UIColor.white // 自定义分页控件小圆标颜色
            circleView.pageDotColor = UIColor.white.withAlphaComponent(0.6)
            circleView.autoScrollTimeInterval = 3.0
            circleView.delegate = self
            tableHeaderView.addSubview(circleView)
            tableView.tableHeaderView = tableHeaderView
       
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  }
extension FirstViewController:UITableViewDelegate,UITableViewDataSource
{  func numberOfSections(in tableView: UITableView) -> Int {
   
    return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return self.listArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var model: HomeDataModel
        
            model = listArray[(indexPath as NSIndexPath).row]!
    
        let cell = HomeTableViewCell.returnHomeTableViewCell(tableView,model: model)
       
            cell.backgroundColor = UIColor.clear
            cell.sepLine.isHidden = true
       
        return cell
        
    }
    
    

}

extension FirstViewController: SDCycleScrollViewDelegate
{
    
    public func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int)
    {
        self.navigationController?.pushViewController(RequestExampleViewController(), animated: true)
        
        
        print("点击了\(index)")
    }

    
}
