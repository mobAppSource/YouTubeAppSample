//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Master on 6/6/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellID")
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

}

class VideoCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
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
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Top, relatedBy: .Equal, toItem: titleLabel, attribute: .Bottom, multiplier: 1, constant: 8))
        //Left Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Left, relatedBy: .Equal, toItem: profileImageView, attribute: .Right, multiplier: 1, constant: 8))
        //RIght Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Right, relatedBy: .Equal, toItem: thumbnaillImageView, attribute: .Right, multiplier: 1, constant: 0))
        //Height Constraint
        addConstraint(NSLayoutConstraint(item: SubTitleTextView, attribute: .Height, relatedBy: .Equal, toItem: self, attribute: .Height, multiplier: 0, constant: 20))
    }
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blackColor()
        
        
        return view
    }()
    
    let thumbnaillImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.blueColor()
        
        
        
        return imageView
    }()
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.greenColor()
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.purpleColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let SubTitleTextView: UITextView = {
        let txtView = UITextView()
        txtView.backgroundColor = UIColor.redColor()
        txtView.translatesAutoresizingMaskIntoConstraints = false
        return txtView
    }()
}

extension UIView{
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerate(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}