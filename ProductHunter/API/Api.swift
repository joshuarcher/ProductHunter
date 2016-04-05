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
        let headers = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        
//        if keychain["authToken"] != nil || keychain["authToken"] != "" {
//            headers["X-Authorization"] = keychain["authToken"]
//        }
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = headers
        
        return configuration
    }
    
    static func apiEndpoint(endpoint: String) -> String {
        // TODO: update for live env
        return "http://jeroen.local:8080\(endpoint)"
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
                    
                    if json["success"] {
                        fulfill(json)
                    } else {
                        reject(ApiError(json: json))
                    }
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
    
    static func post(endpoint: String, paramaters: params) -> Promise<JSON> {
        return request(endpoint, method: .POST, paramaters: paramaters, encoding: .JSON)
    }
    
    static func put(endpoint: String, paramaters: params) -> Promise<JSON> {
        return request(endpoint, method: .PUT, paramaters: paramaters, encoding: .JSON)
    }
    
    static func delete(endpoint: String, paramaters: params) -> Promise<JSON> {
        return request(endpoint, method: .DELETE, paramaters: paramaters, encoding: .URLEncodedInURL)
    }
}