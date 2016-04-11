//
//  UIImage.swift
//  ProductHunter
//
//  Created by Joshua Archer on 4/5/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import Foundation
import UIKit

// courtesy of

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
//            let request = NSURL(URL: url)
            let session = NSURLSession.sharedSession()
            session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                if let data = data {
                    let image = UIImage(data: data)
                    dispatch_async(dispatch_get_main_queue(), { 
                        self.image = image
                    })
                }
            }).resume()
        }
    }
}