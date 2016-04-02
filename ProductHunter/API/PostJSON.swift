//
//  PostJSON.swift
//  ProductHunter
//
//  Created by Joshua Archer on 4/1/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import Foundation
import Gloss

/**
 JSON class for Product Hunt Posts
 */

class PostJSON: Decodable {
    
    // MARK: Properties
    
    let id: String?
    let name: String?
    let tagline: String?
    let discussion_url: String?
    let votes_count: Int?
    
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.tagline = "tagline" <~~ json
        self.discussion_url = "discussion_url" <~~ json
    }
    
}
