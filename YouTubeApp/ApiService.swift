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
    
    func fetchingVideos(completion: ([Video]) -> ())
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
