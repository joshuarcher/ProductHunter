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
            let request = NSURLRequest(URL: url)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
                (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
                self.image = UIImage(data: data!)
            }
        }
    }
}