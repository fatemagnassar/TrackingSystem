//
//  GroupService.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/19/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
import Alamofire
extension Networking{
    
    func retrieveGroups(id:Int,completed: @escaping (_ valid:Bool, _ msg:String, _ groups:[Group])->()) {
        let url = "\(Singleton.sharedInstance.serverBasePath)/Groups"
        let parameters: Parameters = [
            
            "id": id ,
            
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
            
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            guard let repsonseDict = response.result.value as? [String: Any] else { return }
            guard let valid = repsonseDict["valid"] as? Bool else { return }
            if valid {
                guard let groupsArr = repsonseDict["data"] as? [[String : Any]] else { return }
                var groups: [Group] = [Group]()
                for group in groupsArr {
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: group,options: []) {
                        guard let groupModel = try? JSONDecoder().decode(Group.self, from: theJSONData) else {
                            completed(false, "Unexpected Error Please Try Again In A While ", [])
                            return
                        }
                        groups.append(groupModel)
                    }
                }
                completed(true, "Retrieved Data Successfully", groups)
            }
        }
        
    }
    
}
