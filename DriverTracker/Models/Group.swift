
//
//  Group.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/17/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
import Foundation
class Group: Decodable{
    
    var id: Int
    var name: String
    init( id: Int , name: String  ){
        self.id = id
        self.name = name
    }
    
}
