//
//  ViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 11/20/18.
//  Copyright © 2018 Fatema El Zahraa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, CLLocationManagerDelegate{
    var locationManager: CLLocationManager!
    @IBOutlet weak var myMap: MKMapView!
    var ref: DatabaseReference!
    var currentLocation: CLLocationCoordinate2D!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        mapSetup()
        ref = Database.database().reference()
    }
    
    fileprivate func setupLocation(){
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        let status = CLLocationManager.authorizationStatus()
        if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()//rotation
    }
    
    fileprivate func mapSetup(){
        myMap.showsUserLocation = true
        myMap.mapType = MKMapType.standard
        myMap.userTrackingMode = MKUserTrackingMode.followWithHeading
        
    }
    
    // delegate function
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0].coordinate)
        myMap.centerCoordinate = locations[0].coordinate
        print(locations[0].coordinate)
        currentLocation = locations[0].coordinate
        // TODO here update firebase socket
    self.ref.child("users").child(Singleton.sharedInstance.loggedInDriver.first_name).setValue(["Name":
            Singleton.sharedInstance.loggedInDriver.first_name,"lat":currentLocation.latitude,"lon":currentLocation.longitude])
        //self.ref.child("users").child(Singleton.sharedInstance.loggedInDriver.name).setValue(["Name":
            //Singleton.sharedInstance.loggedInDriver.name,"lat":currentLocation.latitude,"lon":currentLocation.longitude])
        // TODO here update firebase socket
    }
    
    
}
