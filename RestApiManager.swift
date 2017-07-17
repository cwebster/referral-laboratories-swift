//
//  RestApiManager.swift
//  ReferralLaboratories
//
//  Created by Craig Webster on 22/05/2017.
//  Copyright © 2017 Craig Webster. All rights reserved.
//

import Foundation

class RestApiManager{
    func getJsonData(urlToRequest:String, completion: @escaping (Data?) -> ()) {
        
        let urlString = URL(string: urlToRequest)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        if let usableUrl = urlString {
            let request = NSMutableURLRequest(url: usableUrl)
            request.httpMethod = "GET"
            request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
            
            let task = session.dataTask(with: request as URLRequest){ (data, response, error) in
                
                if let data = data, error == nil {
                    completion(data)
                } else {
                    print("error=\(error!.localizedDescription)")
                }
            }
            task.resume()
        }
    }
}
