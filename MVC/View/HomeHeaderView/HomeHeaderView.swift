//
//  HomeHeaderView.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/9/5.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit
import SnapKit

class HomeHeaderView: UIView {
    
    lazy var sepLine: UIView = {
        let sepLine = UIView()
        sepLine.backgroundColor = BaseColor.BorderColor
        return sepLine
    }()

    lazy var redLine: UIView = {
        let redLine = UIView()
        redLine.backgroundColor = BaseColor.RedColor
        return redLine
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = BaseColor.GrayColor
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        return titleLabel
    }()

    class func returnHomeHeaderView() -> HomeHeaderView
    {
        let headerView = HomeHeaderView()
        headerView.backgroundColor = UIColor.white
        
        headerView.addSubview(headerView.sepLine)
        headerView.sepLine.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(headerView)
            make.height.equalTo(0.5)
        }

        headerView.addSubview(headerView.redLine)
        headerView.redLine.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView.snp.centerY)
            make.left.equalTo(headerView)
            make.height.equalTo(20)
            make.width.equalTo(3)
        }
        
        headerView.addSubview(headerView.titleLabel)
        headerView.titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView.snp.centerY)
            make.left.equalTo(headerView.redLine.snp.right).offset(8)
        }

        return headerView
    }
}
