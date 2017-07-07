//
//  HomeTableViewCell.swift
//  SimpleSugars
//
//  Created by 苑伟 on 16/8/24.
//  Copyright © 2016年 苑伟. All rights reserved.
//

import UIKit
import Kingfisher
class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var placeholderBtn: UIButton!
    @IBOutlet weak var sepLine: UIView!
    @IBOutlet weak var favoriteBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        favoriteBtn.layer.cornerRadius = 25/2
        favoriteBtn.layer.masksToBounds = true
        bgImageView.layer.cornerRadius = 5
        bgImageView.layer.masksToBounds = true
        bgImageView.layer.shouldRasterize = true
        bgImageView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func returnHomeTableViewCell(_ tableView: UITableView,model: HomeDataModel) -> HomeTableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCell) as! HomeTableViewCell
        cell.selectionStyle = .none
        let url = URL(string: model.cover_image_url!)
        cell.bgImageView?.kf.setImage(with: url,placeholder:UIImage.init(named: "tab_5th_h"))
        cell.favoriteBtn.setTitle(String(stringInterpolationSegment: model.likes_count), for: .normal)
        cell.titleLabel.text = model.title
        return cell
    }
}
