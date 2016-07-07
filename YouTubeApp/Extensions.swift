//
//  Extensions.swift
//  YouTubeApp
//
//  Created by Master on 7/4/16.
//  Copyright © 2016 Master. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
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
//cache for image loading
let imgCache = NSCache()
class CustomImgView: UIImageView{
    var imgUrlString: String?
    func loadImgUsingUrlString(urlString: String) {
        imgUrlString = urlString
        if let imgFromCache = imgCache.objectForKey(urlString) as? UIImage{
            self.image = imgFromCache
            return
        }
        
        image = nil
        let url = NSURL(string: urlString)
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                print(error)
                return
            }
            dispatch_async(dispatch_get_main_queue(), {
                let imgToCache = UIImage(data: data!)
                
                if self.imgUrlString == urlString{
                    self.image = imgToCache
                }
                imgCache.setObject(imgToCache!, forKey: urlString)
            })
        }.resume()
    }
}
