//
//  RetrieveTripsService.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/9/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
import Alamofire

enum TripState: String {
    case completed = "completed"
    case notStarted = "notstarted"
    case inprogress = "inprogress"
}

extension Networking{
    
    func retrieveTrips(id:Int, required: TripState, completed: @escaping (_ valid:Bool, _ msg:String, _ trips:[Trips])->()) {
        let url = "\(Singleton.sharedInstance.serverBasePath)/drivertrips"
        let parameters: Parameters = [
            "id": id ,
            "required": required.rawValue
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
            
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            guard let repsonseDict = response.result.value as? [String: Any] else { return }
            guard let valid = repsonseDict["valid"] as? Bool else { return }
            if valid {
                guard let tripsArr = repsonseDict["data"] as? [[String : Any]] else { return }
                var trips: [Trips] = [Trips]()
                for trip in tripsArr {
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: trip,options: []) {
                        guard let tripModel = try? JSONDecoder().decode(Trips.self, from: theJSONData) else {
                            completed(false, "Unexpected Error Please Try Again In A While ", [])
                            return
                        }
                        trips.append(tripModel)
                    }
                }
                completed(true, "Retrieved Data Successfully", trips)
            }
        }
    }
    
    
    func updateTripStatus(id:Int, status: String, completed: @escaping (_ valid:Bool, _ msg:String)->()){
        let url = "\(Singleton.sharedInstance.serverBasePath)/UpdateTripStatus"
        let parameters: Parameters = [
            "id": id ,
            "status": status
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
            
        ]
        
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
        if let jsonResponse = response.result.value{
        let data = jsonResponse as! [String : Any]
        let valid = data["valid"] as! Bool
        if valid{
        
        completed(true,data["message"] as! String)
        return
        
        }
        
        completed(false,data["message"] as! String)
        }else{
        print("mfish response ")
        
        completed(false, "Unexpected Error Please Try Again In A While ")
        }
        }
        
        
        
        
    }
}
