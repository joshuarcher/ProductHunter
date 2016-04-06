//
//  Api.swift
//  ProductHunter
//
//  Created by Joshua Archer on 4/4/16.
//  Copyright © 2016 Joshua Archer. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

struct ApiError: ErrorType {
    let json: JSON
    
    init(json: JSON) {
        self.json = json
    }
}

struct Api {
    typealias params = [String: AnyObject]?
    
    static var manager = Alamofire.Manager(configuration: Api.getConfiguration())
    
    static func refreshManager() {
        self.manager = Alamofire.Manager(configuration: Api.getConfiguration())
    }
    
    static func getConfiguration() ->  NSURLSessionConfiguration {
        var headers = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
//        headers
        headers["Authorization"] = "Bearer 79411ff6bbbc83e1271a5b7918d907db572ffd663bbcb72587a77ea4c9e0527c"
        
//        let headers = [
//            "Authorization":"Bearer 79411ff6bbbc83e1271a5b7918d907db572ffd663bbcb72587a77ea4c9e0527c",
//            ]
        

        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        
        return configuration
    }
    
    static func apiEndpoint(endpoint: String) -> String {
        // TODO: update for live env
        return "https://api.producthunt.com/v1\(endpoint)"
    }
    
    private static func request(endpoint: String, method: Alamofire.Method, paramaters: params, encoding: ParameterEncoding) -> Promise<JSON> {
        return Promise { fulfill, reject in
            let request = manager.request(method,
                apiEndpoint(endpoint),
                parameters: paramaters,
                encoding: encoding)
                .validate()
            
            request.responseJSON { response -> Void in
                switch response.result {
                case .Success(let data):
                    let json = JSON(data)
                    fulfill(json)
                case .Failure(let error):
                    reject(error)
                    print("Request failed with error: \(error)")
                }
            }
        }
    }
    
    static func get(endpoint: String, paramaters: params) -> Promise<JSON> {
        return request(endpoint, method: .GET, paramaters: paramaters, encoding: .URLEncodedInURL)
    }
}