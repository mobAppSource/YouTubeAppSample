//
//  ApiService.swift
//  YouTubeApp
//
//  Created by MacOS on 7/8/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    //Home Feed
    func fetchingVideos(completion: ([Video]) -> ())
    {
        let url = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        fetchingForURLString(url, completion: completion)
    }
    
    //trending feed
    func fetchingTrendingFeed(completion: ([Video]) -> ())
    {
        let url = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
        fetchingForURLString(url, completion: completion)
    }

    //Subscription Feed
    func fetchingSubscriptionFeed(completion: ([Video]) -> ())
    {
        let url = "https://s3-us-west-2.amazonaws.com/youtubeassets/subscriptions.json"
        fetchingForURLString(url, completion: completion)
    }

    //fetching datas from the url
    func fetchingForURLString(urlString: String, completion: ([Video]) -> ())
    {
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!) {
            (data, response, error) in
            if error != nil{
                print("Error in fetching video info from youtube: \(error?.localizedDescription)")
                return
            }
            //parsing the json data
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers)
                var videos = [Video]()
                for dict in json as! [[String: AnyObject]]{
                    let video = Video()
                    video.title = dict["title"] as? String
                    video.thumbnailImageName = dict["thumbnail_image_name"] as? String
                    let channelDict = dict["channel"] as! [String: AnyObject]
                    let channel = Channel()
                    channel.name = channelDict["name"] as? String
                    channel.profileImgName = channelDict["profile_image_name"] as? String
                    video.channel = channel
                    videos.append(video)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    completion(videos)
                })
            }catch let jsonErr {
                print("JSON Error: \(jsonErr)")
            }
        }.resume()
    }
}
