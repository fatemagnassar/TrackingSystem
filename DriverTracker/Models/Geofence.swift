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
    
    static func loadDummyGeofences() -> [Geofence] {
        let poly = Geofence(points: [CLLocationCoordinate2DMake(49.142677,  -123.135139),CLLocationCoordinate2DMake(49.142730, -123.125794),CLLocationCoordinate2DMake(49.140874, -123.125805),CLLocationCoordinate2DMake(49.140885, -123.135214)], type: .polygon, radius: 0, center: CLLocationCoordinate2DMake(0,0))
        
        let line = Geofence(points: [CLLocationCoordinate2DMake(49.142677,  -123.135139),CLLocationCoordinate2DMake(49.142730, -123.125794),CLLocationCoordinate2DMake(49.140874, -123.125805)], type: .line, radius: 0, center: CLLocationCoordinate2DMake(0,0))
        
        let circle = Geofence(points: [], type: .circle, radius: CLLocationDistance(exactly: 1000)!, center: CLLocationCoordinate2DMake(49.142677,  -123.135139))
        
        return [poly, line, circle]
    }
}
