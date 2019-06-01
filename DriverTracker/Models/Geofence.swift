//
//  Geofence.swift
//  DriverTracker
//
//  Created by Ahmed masoud on 5/18/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
import MapKit

struct Geofence {
    var points: [CLLocationCoordinate2D]
    var type: GeofenceType
    var radius: CLLocationDistance
    var center: CLLocationCoordinate2D
    var id: Int
    var speedlimit : Double?
    var flagSpeed : Bool
    
    /*init( points: [CLLocationCoordinate2D],type: GeofenceType,radius: CLLocationDistance,center: CLLocationCoordinate2D,id: Int,speedlimit : Int,flagSpeed : Bool){
     self.points = points
     self.type = type
     self.radius = radius
     self.center = center
     self.id = id
     self.speedlimit = speedlimit
     self.flagSpeed = flagSpeed
     }*/
}
