//
//  RestrictionService.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/15/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
import Alamofire
extension Networking{
    
    func retrieveRestrictions(id:Int, completed: @escaping (_ valid:Bool, _ msg:String, _ restrictions:[Restriction])->()) {
        let url = "\(Singleton.sharedInstance.serverBasePath)/driverViolations"
        let parameters: Parameters = [
            "group_id": id ,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
            
]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            guard let repsonseDict = response.result.value as? [String: Any] else { return }
            guard let valid = repsonseDict["valid"] as? Bool else { return }
            if valid {
                guard let restrictionsArr = repsonseDict["data"] as? [[String : Any]] else { return }
                var restricions: [Restriction] = [Restriction]()
                for restriction in restrictionsArr {
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: restriction,options: []) {
                        guard let restrictionModel = try? JSONDecoder().decode(Restriction.self, from: theJSONData) else {
                            completed(false, "Unexpected Error Please Try Again In A While ", [])
                            return
                        }
                        restricions.append(restrictionModel)
                    }
                }
                completed(true, "Retrieved Data Successfully", restricions)
            }
        }
    }
    
   
}
