//
//  MenuBar.swift
//  YouTubeApp
//
//  Created by Master on 7/4/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private let cellID = "cellID"
    let imageNames = ["home", "trending", "subscriptions", "account"]
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.rgb(230, green: 32, blue: 31, alpha: 1)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! MenuCell
        cell.imgView.image = UIImage(named: self.imageNames[indexPath.row])?.imageWithRenderingMode(.AlwaysTemplate)
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(frame.width/4, frame.height)
    }
    //interval between the cell items
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        // adding collectionView for swiping the viewcontrollers.
        collectionView.registerClass(MenuCell.self, forCellWithReuseIdentifier: cellID)
        
        
        backgroundColor = UIColor.rgb(230, green: 32, blue: 31, alpha: 1)
        addSubview(collectionView)
        
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        //preselected the home page when the app launched
        let selectedIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        collectionView.selectItemAtIndexPath(selectedIndexPath, animated: false, scrollPosition: .None)
        
    }
    
    
}

class MenuCell: BaseCell
{
    //Selecting the cell, it will be highlighted
    override var highlighted: Bool {
        didSet{
            imgView.tintColor = highlighted ? UIColor.whiteColor(): UIColor.rgb(91, green: 14, blue: 14, alpha: 1)
        }
    }
    //Selecting the cell, it will be highlighted
    override var selected: Bool {
        didSet{
            imgView.tintColor = selected ? UIColor.whiteColor(): UIColor.rgb(91, green: 14, blue: 14, alpha: 1)
        }
    }
    
    let imgView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")
        iv.tintColor = UIColor.rgb(91, green: 14, blue: 14, alpha: 1)
        return iv
        
    }()
    override func setupViews()
    {
        super.setupViews()
        
        addSubview(imgView)
        addConstraintsWithFormat("H:[v0(28)]", views: imgView)
        addConstraintsWithFormat("V:[v0(28)]", views: imgView)
        
        addConstraint(NSLayoutConstraint(item: imgView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imgView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        
        
        
        
        
        
        
        
        
    }
}