//
//  Singleton.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 11/30/18.
//  Copyright © 2018 Fatema El Zahraa. All rights reserved.
//
// data el 3izha shared across app kolo w msh bttghyr

import Foundation
class Singleton {
    static let sharedInstance = Singleton()
    let serverBasePath = "http://192.168.1.5:8000/api"
    var loggedInDriver: Driver!
    var flag : Int!


    private init(){}
}

