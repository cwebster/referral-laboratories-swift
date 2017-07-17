import PlaygroundSupport
import Foundation



PlaygroundPage.current.needsIndefiniteExecution = true
URLCache.shared = URLCache(memoryCapacity: 0, diskCapacity: 0, diskPath: nil)

struct Repertoire {
    let attributes: [String:Any]
    let id : Int
    let links: String?
    let type: String
    var hostLaboratoryID: Int
}


extension Repertoire {
    init?(JSON: Any, hostLaboratoryID: Int) throws {
        guard let JSON = JSON as? [String: AnyObject] else { return nil }
        
        guard let attributes = JSON["attributes"]?["analyte"] as? [String: Any] else {
            return nil
        }
        
        guard let record_id = JSON["id"] as? String else {
            return nil
        }
        
        let link = JSON["links"] ?? "Definitely Not Nil Variable" as AnyObject
        let typestr = JSON["type"] ?? "Definitely Not Nil Variable" as AnyObject
        
        self.attributes = attributes
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

Repertoire.repertoires(hostLaboratoryID: 117){repertoires
    in
print(repertoires)
    
}