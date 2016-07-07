//
//  ViewController.swift
//  YouTubeApp
//
//  Created by Master on 6/6/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    private let cellID = "cellID"
    let cellColors:[UIColor] = [.redColor(), .greenColor(), .blueColor(), .grayColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleBar = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleBar.text = "Home"
        titleBar.textColor = UIColor.whiteColor()
        titleBar.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleBar
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarBtn()
        self.fetchingVideos()
    }
    func setupCollectionView()
    {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.scrollDirection = .Horizontal
            flowLayout.minimumLineSpacing = 0
        }
        navigationController?.navigationBar.translucent = false
        collectionView?.backgroundColor = UIColor.whiteColor()
//        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        //move down for 50 to display the whole cell
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.pagingEnabled = true
        
    }
    //fetching videos from youtube with json data format
    func fetchingVideos()
    {
        ApiService.sharedInstance.fetchingVideos {
            (videos: [Video]) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }
    //adding finding and more buttons on the navigationBar
    func setupNavBarBtn()
    {
        let searchImg = UIImage(named: "search_icon")?.imageWithRenderingMode(.AlwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImg, style: .Plain, target: self, action: #selector(actionFinding))
        
        let moreImg = UIImage(named: "nav_more_icon")?.imageWithRenderingMode(.AlwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImg, style: .Plain, target: self, action: #selector(actionMoreBtn))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    func actionFinding()
    {
        print("tapped serach button on the navigation bar")
        scrollToMenuIndex(2)
    }
    func scrollToMenuIndex(mIndex: Int){
        let indexPath = NSIndexPath(forItem: mIndex, inSection: 0)
        collectionView?.scrollToItemAtIndexPath(indexPath, atScrollPosition: .None, animated: true)
    }
    
    
    
    let settingsLauncher = SettingsLauncher()
    func actionMoreBtn()
    {
        settingsLauncher.showSettings()
    }
    //action for more items view dismiss
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setupMenuBar()
    {
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(230, green: 32, blue: 31, alpha: 1)
        view.addSubview(redView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: redView)
        view.addConstraintsWithFormat("V:[v0(50)]", views: redView)
        
        
        view.addSubview(menuBar)
        
        //Constraints for horizontal and vertical
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor).active = true
        
    }
    override func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.memory.x/view.frame.width)
        let indexPath = NSIndexPath(forItem: index, inSection: 0)
        menuBar.collectionView.selectItemAtIndexPath(indexPath, animated: true, scrollPosition: .None)
    }
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x/4
    }
    
    //MARK: -
    //MARK: sliding section move
    //mark: -
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
        cell.backgroundColor = cellColors[indexPath.item]
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, view.frame.height)
    }
    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videos?.count ?? 0
////        return videos.count
//    }
//    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath) as! VideoCell
//        cell.video = videos![indexPath.item]
////        cell.video = videos[indexPath.item]
//        return cell
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let height = (self.view.frame.size.width - 16 - 16) * 9 / 16
//        return CGSizeMake(view.frame.width, height + 16 + 88)
//    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
//        return 0
//    }

}