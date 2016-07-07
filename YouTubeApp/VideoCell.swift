//
//  VideoCell.swift
//  YouTubeApp
//
//  Created by Master on 7/4/16.
//  Copyright © 2016 Master. All rights reserved.
//

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
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnaillImageView, profileImageView, separatorView)
        
        //Separator line
        addConstraintsWithFormat("H:|[v0]|", views: separatorView)
        
        //Top Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: thumbnaillImageView, attribute: .Bottom, multiplier: 1, constant: 8))
        //Left Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: profileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //Right Constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: thumbnaillImageView, attribute: .Right, multiplier: 1, constant: 0))
        //Height Constraint
        titleLableHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 44)
        addConstraint(titleLableHeightConstraint!)
        
        //Top Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 4))
        //Left Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Left, relatedBy: .Equal, toItem: profileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //RIght Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnaillImageView, attribute: .Right, multiplier: 1, constant: 0))
        //Height Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 30))
    }
    //Adding video property
    
    var video: Video?{
        didSet{
            titleLabel.text = video?.title
            
//            thumbnaillImageView.image = UIImage(named: (video?.thumbnailImageName)!)
            setupThumbnailImage()
//            if let profileImgName = video?.channel?.profileImgName{
////                profileImageView.image = UIImage(named: profileImgName)
//                
//            }
            setupProfileImage()
            if let channelName = video?.channel?.name, numberOfViews = video?.numberOfViews{
                let numberFormmater = NSNumberFormatter()
                numberFormmater.numberStyle = .DecimalStyle
                
                let subTitleText = "\(channelName) • \(numberFormmater.stringFromNumber(numberOfViews)!) • 3 years ago "
                SubTitleTextView.text = subTitleText
            }
            //Measuring the heght of title text
            if let title = video?.title{
                let size = CGSizeMake(frame.size.width - 16  - 44 - 8 - 16 - 8, 1000)
                let options = NSStringDrawingOptions.UsesFontLeading.union(.UsesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRectWithSize(size, options: options, attributes:[NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
                
                titleLableHeightConstraint?.constant = estimatedRect.size.height > 20 ? 44: 20
            }
        }
    }
    
    func setupProfileImage()
    {
        if let profileImgURL = video?.thumbnailImageName{
            profileImageView.loadImgUsingUrlString(profileImgURL)
        }
    }
    //loading the thumbnail image from youtube.
    func setupThumbnailImage()
    {
        if let thumbnailImgURL = video?.thumbnailImageName{
            thumbnaillImageView.loadImgUsingUrlString(thumbnailImgURL)
        }
    }
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        
        return view
    }()
    
    let thumbnaillImageView: CustomImgView = {
        let imageView = CustomImgView()
        imageView.backgroundColor = UIColor.blueColor()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    let profileImageView: CustomImgView = {
        let imageView = CustomImgView()
        imageView.backgroundColor = UIColor.greenColor()
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.blueColor().CGColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .ScaleAspectFill
        
        return imageView
    }()
    var titleLableHeightConstraint: NSLayoutConstraint?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.sizeToFit()
        label.numberOfLines = 2
        return label
    }()
    let SubTitleTextView: UITextView = {
        let txtView = UITextView()
        txtView.translatesAutoresizingMaskIntoConstraints = false
        txtView.text = "TaylorSwiftVevo ∙ 1,604,234,343 views ∙ 3 years"
        txtView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        txtView.textColor = UIColor.lightGrayColor()
        txtView.userInteractionEnabled = false
        return txtView
    }()
}

