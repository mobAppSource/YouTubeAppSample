//
//  SubscriptionCell.swift
//  YouTubeApp
//
//  Created by MacOS on 7/9/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchingVideos() {
        ApiService.sharedInstance.fetchingSubscriptionFeed {
            (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
    
}
