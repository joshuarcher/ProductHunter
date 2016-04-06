//
//  ProductEndpoint.swift
//  ProductHunter
//
//  Created by Joshua Archer on 4/4/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import Foundation
import SwiftyJSON
import PromiseKit

struct PostsEndpoint {
    let endpoint = "/posts"
    
    func list() -> Promise<[PostJSON]> {
//        let params: Api.params = [
//            "Authorization":"Bearer 79411ff6bbbc83e1271a5b7918d907db572ffd663bbcb72587a77ea4c9e0527c",
//            ]
        
        return Api.get(endpoint, paramaters: [:])
            .then { (json) -> [PostJSON] in
                var posts = [PostJSON]()
                // Map t he data
                for (_,subJson):(String, JSON) in json["posts"] {
                    posts.append(
                        PostJSON(json: subJson)!
                    )
                }
                return posts
        }
    }
    
    func get(id: String) -> Promise<PostJSON> {
        return Api.get("\(endpoint)/\(id)", paramaters: nil).then { (json) -> PostJSON in
            return PostJSON(json: json)!
        }
        
    }
}