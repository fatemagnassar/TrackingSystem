//
//  Restriction.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/15/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
class Restriction: Decodable{
    
    var id: Int
    var name: String
    var value: String
    init( id: Int , name: String , value: String ){
        self.id = id
        self.name = name
        self.value = value
    }
    
}
