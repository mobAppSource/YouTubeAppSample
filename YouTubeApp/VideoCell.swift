//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Master on 7/4/16.
//  Copyright © 2016 Master. All rights reserved.
//

import Foundation
import UIKit

//Base UICollectionViewCell class

class BaseCell: UICollectionViewCell
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        
    }
}

class VideoCell: BaseCell{
    
    
    override func setupViews() {
        
        addSubview(thumbnaillImageView)
        addSubview(separatorView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(SubTitleTextView)
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnaillImageView)
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: profileImageView)
        
        // Vertical constraints
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnaillImageView, profileImageView, separatorView)
        
        //Separator line
        addConstraintsWithFormat("H:|[v0]|", views: separatorView)
        
        //Top Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnaillImageView, attribute: .Bottom, multiplier: 1, constant: 8))
        //Left Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: profileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //RIght Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: thumbnaillImageView, attribute: .Right, multiplier: 1, constant: 0))
        //Height Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 20))
        
        //Top Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
        //Left Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Left, relatedBy: .Equal, toItem: profileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //RIght Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnaillImageView, attribute: .Right, multiplier: 1, constant: 0))
        //Height Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
    }
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        
        return view
    }()
    
    let thumbnaillImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blueColor()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.greenColor()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.blueColor().CGColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //        label.backgroundColor = UIColor.purpleColor()
        label.text = "Taylor Swift - Blank Space"
        
        return label
    }()
    let SubTitleTextView: UITextView = {
        let txtView = UITextView()
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.text = "TaylorSwiftVevo ∙ 1,604,234,343 views ∙ 3 years"
        txtView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        txtView.textColor = UIColor.lightGrayColor()
        return txtView
    }()
}

