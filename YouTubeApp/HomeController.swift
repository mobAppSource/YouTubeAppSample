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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleBar = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleBar.text = "Home"
        titleBar.textColor = UIColor.whiteColor()
        titleBar.font = UIFont.systemFontOfSize(20)
        navigationItem.titleView = titleBar
        
        
        navigationController?.navigationBar.translucent = false
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(VideoCell.self, forCellWithReuseIdentifier: "cellID")
        //move down for 50 to display the whole cell
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        setupMenuBar()
        setupNavBarBtn()
        self.fetchingVideos()
    }
    //fetching videos from youtube with json data format
    func fetchingVideos()
    {
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            if error != nil{
                print("Error in fetching video info from youtube: \(error?.localizedDescription)")
                return
            }
            //parsing the json data
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                self.videos = [Video]()
                for dict in json as! [[String: AnyObject]]{
                    let video = Video()
                    video.title = dict["title"] as? String
                    video.thumbnailImageName = dict["thumbnail_image_name"] as? String
                    let channelDict = dict["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDict["name"] as? String
                    channel.profileImgName = channelDict["profile_image_name"] as? String
                    video.channel = channel
                    
                    
                    self.videos?.append(video)
                    
                }
                dispatch_async(dispatch_get_main_queue(), { 
                    self.collectionView?.reloadData()
                })
            }catch let jsonErr {
                print("JSON Error: \(jsonErr)")
            }
            
            
            
            
            
            
        }.resume()
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
    }
    let settingsLauncher = SettingsLauncher()
    func actionMoreBtn()
    {
        settingsLauncher.showSettings()
    }
    //action for more items view dismiss
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar()
    {
        view.addSubview(menuBar)
        
        //Constraints for horizontal and vertical
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(50)]", views: menuBar)
        
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
//        return videos.count
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath) as! VideoCell
        cell.video = videos![indexPath.item]
//        cell.video = videos[indexPath.item]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let height = (self.view.frame.size.width - 16 - 16) * 9 / 16
        return CGSizeMake(view.frame.width, height + 16 + 88)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

}