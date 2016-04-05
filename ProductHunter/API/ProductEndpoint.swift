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
    static let endpoint = "/posts"
    
    static func list(latitude: Float, longitude: Float, page: Int, radius: Int, searchTerm: String) -> Promise<[PostJSON]> {
        var params: Api.params = ["latitude": latitude, "longitude": longitude, "page": page, "radius": radius]
        
        let headers = [
            "Authorization":"Bearer 79411ff6bbbc83e1271a5b7918d907db572ffd663bbcb72587a77ea4c9e0527c",
            ]

        
        if searchTerm != "" {
            params!["search_term"] = searchTerm
        }
        
        return Api.get(endpoint, paramaters: params)
            .then { (json) -> [PostJSON] in
                var posts = [PostJSON]()
                // Map t he data
                for (_,subJson):(String, JSON) in json["data"] {
                    posts.append(
                        PostJSON(json: subJson)!
                    )
                }
                return posts
        }
    }
    
    static func get(id: String) -> Promise<PostJSON> {
        return Api.get("\(endpoint)/\(id)", paramaters: nil).then { (json) -> PostJSON in
            return PostJSON(json: json)!
        }
        
    }
    
    static func post(post: PostJSON) -> Promise<PostJSON> {
        return Api.post(endpoint, paramaters: post.paramaters()).then { (json) -> Post in
            return Post(json: json)
        }
    }
    
    static func put(id: String, post: PostJSON) -> Promise<PostJSON> {
        return Api.put("\(endpoint)/\(id)", paramaters: post.paramaters()).then { (json) -> Post in
            return Post(json: json)
        }
    }
}