//
//  RestrictionService.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/15/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
import Alamofire
import MapKit

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
    
    func retrieveGeofences(id:Int, completed: @escaping (_ valid:Bool, _ msg:String, _ geofences:[Geofence])->()){
        let url = "\(Singleton.sharedInstance.serverBasePath)/restrictions"
        let parameters: Parameters = [
            "trip_id": id ,
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        var flagspeed = true
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            guard let repsonseDict = response.result.value as? [String: Any] else { return }
            guard let valid = repsonseDict["valid"] as? Bool else { return }
            if valid {
                guard let geoFencesArr = repsonseDict["data"] as? [[String : Any]] else { return }
                var geofences: [Geofence] = [Geofence]()
                for geo in geoFencesArr {
                    flagspeed = true
                    guard let geoid = geo["restriction_id"] as? Int else { return }
                    if geo["speedlimit"] == nil {
                        flagspeed = false
                    }
                    let points = geo["points"] as! [[Double]]
                    var geoFencePoints: [CLLocationCoordinate2D] = []
                    for point in points {
                        let coordinate = CLLocationCoordinate2DMake(point.first!,  point.last!)
                        geoFencePoints.append(coordinate)
                    }
                    geofences.append(Geofence(points: geoFencePoints, type: .polygon, radius: 0, center: CLLocationCoordinate2DMake(0,0), id: geoid, speedlimit: geo["speedlimit"] as? Double ?? 0, flagSpeed: flagspeed))
                }
                completed(true, "Retrieved Data Successfully", geofences)
            }
        }
    }
    
    func saveViolation(lat: String, long : String ,trip_id:Int,driver_id : Int , restriction_id : Int, completed: @escaping (_ valid:Bool, _ msg:String)->()) {
        let url = "\(Singleton.sharedInstance.serverBasePath)/AddDriverViolations"
        let parameters: Parameters = [
            "trip_id": trip_id ,
            "driver_id": driver_id ,
            "restriction_id": restriction_id ,
            "lat": lat,
            "long": long,
            
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
            
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            guard let repsonseDict = response.result.value as? [String: Any] else { return }
            guard let valid = repsonseDict["valid"] as? Bool else { return }
            if valid {
                completed(true, "Violation saved Successfully")
                
            }
            else {
                completed(false, "Error")
                
            }
        }
    }
}

