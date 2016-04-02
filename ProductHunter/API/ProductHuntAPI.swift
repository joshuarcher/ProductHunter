//
//  ProductHuntAPI.swift
//  ProductHunter
//
//  Created by Joshua Archer on 4/1/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import Foundation
import Alamofire
import Gloss

class ProductHuntAPI {
    
    
    /**
     Tech posts of the day
     GET https://api.producthunt.com/v1/posts
     */
    func ph_techPosts() {
        
        // Add Headers
        let headers = [
            "Authorization":"Bearer 79411ff6bbbc83e1271a5b7918d907db572ffd663bbcb72587a77ea4c9e0527c",
            ]
        
        // Fetch Request
        Alamofire.request(.GET, "https://api.producthunt.com/v1/posts", headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.data)")
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
        }
    }
    
    
}