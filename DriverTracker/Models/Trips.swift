//
//  Driver.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 11/30/18.
//  Copyright © 2018 Fatema El Zahraa. All rights reserved.
//

import Foundation

class Trips: Decodable{
    var id: Int
    var driver_id: Int
    var start_lat: String
    var start_long: String
    var end_lat: String
    var end_long: String
    var state: String
    var date_time: String
    var estimated_time: String
    var to_address: String
    var from_address: String
    var vehicle_name : String
    var region_name : String
    var city_name : String
    var destination_region_name : String
    var destination_city_name : String
    var vehicle_id : Int
    var region_id : Int
    var city_id : Int
    var destination_region_id : Int
    var destination_city_id : Int
    var trip_name : String
    

    init(id: Int, start_lat: String,start_long: String, end_lat: String,end_long: String, state: String , date_time: String, estimated_time: String ,to_address:String ,from_address:String , vehicle_name : String ,region_name : String , city_name : String ,destination_region_name : String , destination_city_name : String , driver_id : Int,vehicle_id : Int ,region_id : Int ,city_id : Int,destination_region_id : Int,destination_city_id : Int,trip_name:String) {
    //init(id: Int, start_lat: String,start_long: String, end_lat: String,end_long: String, state: String , date_time: String, estimated_time: String  , vehicle_name : String ,region_name : String , city_name : String ,destination_region_name : String , destination_city_name : String , driver_id : Int,vehicle_id : Int ,region_id : Int ,city_id : intmax_t,destination_region_id : Int,destination_city_id : Int) {
        self.trip_name = trip_name
        self.id = id
        self.driver_id = driver_id
        self.to_address = to_address
        self.from_address=from_address
        self.start_lat = start_lat
        self.start_long = start_long
        self.end_lat = end_lat
        self.end_long = end_long
        self.date_time = date_time
        if state=="notstarted"
            {self.state = "Not Started"}
        else if state=="completed"{
            self.state = "Completed"}
        else if state=="notStarted"{
            self.state = "Not Started"}
        else if state=="finished"{
            self.state = "Finished"}
            
        else{
            self.state=state
        }
        self.estimated_time = estimated_time
        self.destination_city_name = destination_city_name
        self.destination_region_name = destination_region_name
        self.city_name = destination_city_name
        self.region_name = destination_region_name
        self.vehicle_name = vehicle_name
        self.city_id=city_id
        self.destination_city_id=destination_city_id
        self.vehicle_id=vehicle_id
        self.region_id=region_id
        self.destination_region_id=destination_region_id
        
        
        
        
    }
}
