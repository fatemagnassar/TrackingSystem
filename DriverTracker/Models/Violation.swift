//
//  Violation.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/15/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
class Violation: Decodable{
    
    var id: Int
    var driver_id: Int
    var trip_id: Int
    var restriction_id: Int
    var long : String
    var lat : String
    var date_time : String
    var trip_name: String
    var restriction_name: String
    
    //init(id: Int, driver_id : Int , trip_id: Int, restriction_id: Int , trip_name: String ,restriction_name: String,long : String, lat : String,date_time : String) {
    init(id: Int, trip_name: String ,restriction_name: String,driver_id : Int , trip_id: Int, restriction_id: Int ,long : String, lat : String,date_time : String) {
        self.lat = lat
        self.long = long
        self.date_time = date_time
        self.id = id
        self.driver_id = driver_id
        self.trip_id = trip_id
        self.restriction_id = restriction_id
        self.trip_name = trip_name
        self.restriction_name = restriction_name
        
    }

}
