//
//  PostJSON.swift
//  ProductHunter
//
//  Created by Joshua Archer on 4/1/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
 SwiftJSON class
 */

struct PostJSON {
    
    // MARK: Properties
    
    var id: Int
    var name: String?
    var tagline: String?
    var discussion_url: String?
    var votes_count: Int?
    var thumbnail_url: String?
    
    init?(json: JSON) {
        //self.id = json["id"].string
        guard let id_int = json["id"].int else {return nil}
        self.id = id_int
        self.name = json["name"].stringValue
        self.tagline = json["tagline"].stringValue
        self.discussion_url = json["discussion_url"].stringValue
        self.votes_count = json["votes_count"].intValue
        self.thumbnail_url = json["thumbnail"]["image_url"].stringValue
    }
    
}
