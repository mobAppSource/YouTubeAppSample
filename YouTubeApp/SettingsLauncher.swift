//
//  SettingsLauncher.swift
//  YouTubeApp
//
//  Created by Master on 7/5/16.
//  Copyright © 2016 Master. All rights reserved.
//

import UIKit

class SettingsLauncher: NSObject{
    
    var blackView = UIView()
    
    //Show the setting items in the setting view
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.whiteColor()
        return cv
    }()
    
    func showSettings()
    {
        //        print("tapped more button on the navigation bar")
        if let window = UIApplication.sharedApplication().keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.alpha = 0
            //integrating the tapgesture function in the blackview
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height:CGFloat = 200
            let y = window.frame.height - height
            collectionView.frame = CGRectMake(0, window.frame.height, window.frame.width, height)
            UIView.animateWithDuration(1.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .CurveEaseOut, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRectMake(0, y, self.collectionView.frame.width, self.collectionView.frame.height)
                }, completion: nil)
            
            blackView.frame = window.frame
            //Adding animation of black view
            UIView.animateWithDuration(0.5) {
                self.blackView.alpha = 1
            }
        }
        
    }
    //action for more items view dismiss
    func handleDismiss()
    {
        UIView.animateWithDuration(0.5) {
            self.blackView.alpha = 0
            if let window = UIApplication.sharedApplication().keyWindow{
                self.collectionView.frame = CGRectMake(0, window.frame.height, self.collectionView.frame.width, self.collectionView.frame.height)
            }
        }
    }
    
    
    override init() {
        super.init()
    }
    
}
