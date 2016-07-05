//
//  SettingCell.swift
//  YouTubeApp
//
//  Created by Master on 7/5/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class Setting: NSObject{
    var name: String
    var iconImgName: String
    
    init(name: String, iconImageName: String) {
        self.name = name
        self.iconImgName = iconImageName
    }
}


class SettingCell: BaseCell {
    
    override var highlighted: Bool {
        didSet{
            backgroundColor = highlighted ? UIColor.darkGrayColor(): UIColor.whiteColor()
            nameLabel.textColor = highlighted ? UIColor.whiteColor(): UIColor.blackColor()
            iconImgView.tintColor = highlighted ? UIColor.whiteColor(): UIColor.darkGrayColor()
        }
    }
    
    var setting: Setting? {
        didSet{
            nameLabel.text = setting?.name
            if let iconName = setting?.iconImgName{
                iconImgView.image = UIImage(named: iconName)?.imageWithRenderingMode(.AlwaysTemplate)
                iconImgView.tintColor = UIColor.darkGrayColor()
            }
        }
    }
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFontOfSize(13)
        return label
    }()
    
    let iconImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "settings")
        imgView.contentMode = .ScaleAspectFill
        return imgView
        
    }()
    
    
    
    override func setupViews() {
        super.setupViews()
        addSubview(nameLabel)
        addSubview(iconImgView)
        addConstraintsWithFormat("H:|-8-[v0(30)]-8-[v1]|", views: iconImgView, nameLabel)
        addConstraintsWithFormat("V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat("V:[v0(30)]", views: iconImgView)
        
        //centering
        addConstraint(NSLayoutConstraint(item: iconImgView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
    }
}
