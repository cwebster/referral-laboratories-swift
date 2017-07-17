//
//  ApiV1.swift
//  ReferralLaboratories
//
//  Created by Craig Webster on 26/03/2017.
//  Copyright © 2017 Craig Webster. All rights reserved.
//

import Foundation

// Do any additional setup after loading the view, typically from a nib.

func LoadJSONFrom(url: URL)   {
    let requestURL: NSURL = NSURL(string: "http://www.learnswiftonline.com/Samples/subway.json")!
    let urlRequest: NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
    let session = URLSession.shared
    _ = session.dataTask(with: urlRequest as URLRequest) {
        (data, response, error) -> Void in
        
        let httpResponse = response as! HTTPURLResponse
        let statusCode = httpResponse.statusCode
        
        if (statusCode == 200) {
            print("Everyone is fine, file downloaded successfully.")
        }
    }
 
}
