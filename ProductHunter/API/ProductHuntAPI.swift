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
    
    private let headers = [
        "Authorization":"Bearer 79411ff6bbbc83e1271a5b7918d907db572ffd663bbcb72587a77ea4c9e0527c",
        ]
    
    
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
    
    func getCollections() -> Promise<[PostJSON]> {
        return ph_recentCollections()
            .then { (json) -> [PostJSON] in
                var collections = [PostJSON]()
                for (_,subJson):(String, JSON) in json["posts"] {
                    print(subJson)
                    let post = PostJSON(json: subJson)
                    print(post)
                    collections.append(post!)
                }
                return collections
            }
    }
    
    
    private func ph_techPosts() -> Promise<JSON> {

        
        return Promise { fulfill, reject in
            // Fetch Request
            Alamofire.request(.GET, "https://api.producthunt.com/v1/posts?days_ago=1", headers: self.headers)
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
    
    private func ph_recentCollections() -> Promise<JSON> {
        /**
         GET https://api.producthunt.com//v1/collections
         */
        
        // Fetch Request
        
        return Promise { fulfill, reject in
            
            Alamofire.request(.GET, "https://api.producthunt.com//v1/collections", headers: self.headers)
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