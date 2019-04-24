//
//  ViolationService.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/15/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
import Alamofire
extension Networking{
    
    func retrieveViolations(id:Int, completed: @escaping (_ valid:Bool, _ msg:String, _ violations:[Violation])->()) {
        let url = "\(Singleton.sharedInstance.serverBasePath)/driverViolations"
        let parameters: Parameters = [
            "driver_id": id ,
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
            
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            guard let repsonseDict = response.result.value as? [String: Any] else { return }
            guard let valid = repsonseDict["valid"] as? Bool else { return }
            if valid {
                guard let violationsArr = repsonseDict["data"] as? [[String : Any]] else { return }
                var violations: [Violation] = [Violation]()
                for violation in violationsArr {
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: violation,options: []) {
                        guard let tripModel = try? JSONDecoder().decode(Violation.self, from: theJSONData) else {
                            completed(false, "Unexpected Error Please Try Again In A While ", [])
                            return
                        }
                        violations.append(tripModel)
                    }
                }
                completed(true, "Retrieved Data Successfully", violations)
            }
        }
    }
    
    
}
