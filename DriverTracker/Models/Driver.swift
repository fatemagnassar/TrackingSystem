//
//  Driver.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 11/30/18.
//  Copyright © 2018 Fatema El Zahraa. All rights reserved.
//

import Foundation

class Driver: Decodable {
    var id: Int
    var user_name: String
    var first_name: String
    //var name: String
    var last_name: String
    var phone: String
    var address: String
    var email: String
    var driver_id: Int

   init(id: Int,driver_id: Int, user_name: String, first_name: String,last_name: String, email: String , phone: String, address: String) {

        self.driver_id = driver_id
        self.user_name = user_name
        //self.name=name
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.phone = phone
        self.address = address
        self.id = id
    }
    


}
