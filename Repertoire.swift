//
//  Repertoire.swift
//  ReferralLaboratories
//
//  Created by Craig Webster on 12/07/2017.
//  Copyright © 2017 Craig Webster. All rights reserved.
//

import Foundation
// Resource class
struct Repertoire {
    let attributes: (analyteName: String, snomed: String?, readCode: String?)
    let id : Int
    let links: String?
    let type: String
    var hostLaboratoryID: Int
}


extension Repertoire {
    init?(JSON: Any, hostLaboratoryID: Int) throws {
        guard let JSON = JSON as? [String: AnyObject] else { return nil }
        
        guard let analyteNameName = JSON["attributes"]?["analyte-name"] as? String else {
            return nil
        }
        
        guard let record_id = JSON["id"] as? String else {
            return nil
        }
        
        let snomodCode = JSON["attributes"]?["snomed"] ?? "Definitely Not Nil Variable"
        let readCodeCode = JSON["attributes"]?["read-code"] ?? "Definitely Not Nil Variable"
        let link = JSON["links"] ?? "Definitely Not Nil Variable" as AnyObject
        let typestr = JSON["type"] ?? "Definitely Not Nil Variable" as AnyObject
        
        self.attributes = (analyteName: analyteNameName, snomed: snomodCode as? String, readCode: readCodeCode as? String)
        self.id = Int(record_id)!
        self.links = link as? String
        self.type = typestr as! String
        self.hostLaboratoryID = hostLaboratoryID
    }
}



extension Repertoire {
    
    static func repertoires(hostLaboratoryID: Int, completion:  @escaping (Array<Any>) -> ()) {
        let urlString = "https://api.reflabs.uk/api/v1/repertoires/" + String(hostLaboratoryID)
        
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error ?? "No Error")
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    
                    if let labTests = parsedData["data"] as? [[String:Any]] {
                        var repertoires: [Repertoire] = []
                        for case let result in labTests {
                            if let repertoire = try Repertoire(JSON: result, hostLaboratoryID: hostLaboratoryID) {
                                repertoires.append(repertoire)
                            }
                        }
                        completion(repertoires)
                    }
                } catch let error as NSError {
                    print(error )
                }
            }
            
            }.resume()
    }
}
