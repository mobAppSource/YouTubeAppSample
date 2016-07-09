//
//  TrendingCell.swift
//  YouTubeApp
//
//  Created by MacOS on 7/9/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class TrendingCell: FeedCell {

    override func fetchingVideos() {
        ApiService.sharedInstance.fetchingTrendingFeed {
            (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
