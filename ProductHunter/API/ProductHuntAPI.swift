//
//  ProductHuntAPI.swift
//  ProductHunter
//
//  Created by Joshua Archer on 4/1/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

struct ProductHuntAPI {
    
    
    /**
     Tech posts of the day
     GET https://api.producthunt.com/v1/posts
     */
    
    func getTechPosts() -> Promise<[PostJSON]> {
        return ph_techPosts()
            .then { (json) -> [PostJSON] in
                var posts = [PostJSON]()
                for (_,subJson):(String, JSON) in json["posts"] {
                    print(subJson)
                    let post = PostJSON(json: subJson)
                    print(post)
                    posts.append(post!)
                }
                return posts
            }
    }
    
    
    private func ph_techPosts() -> Promise<JSON> {
        
        // Add Headers
        let headers = [
            "Authorization":"Bearer 79411ff6bbbc83e1271a5b7918d907db572ffd663bbcb72587a77ea4c9e0527c",
            ]
        
        return Promise { fulfill, reject in
            // Fetch Request
            Alamofire.request(.GET, "https://api.producthunt.com/v1/posts?days_ago=1", headers: headers)
                .validate(statusCode: 200..<300)
                .responseJSON { response in
                    switch response.result {
                    case .Success(let data):
                        let json = JSON(data)
                        fulfill(json)
                    case .Failure(let error):
                        debugPrint("HTTP Request failed: \(error)")
                    }
            }
        }
    }
    
    
}