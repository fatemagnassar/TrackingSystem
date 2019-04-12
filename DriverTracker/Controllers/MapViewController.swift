//
//  MapViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/11/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase
import SwiftSpinner
import SCLAlertView

class MapViewController: UIViewController , CLLocationManagerDelegate{
    var tripSelected: Trips!
    var ref: DatabaseReference!
    @IBOutlet weak var myMap: MKMapView!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()
        mapSetup()
        ref = Database.database().reference()
        let annotation = MKPointAnnotation()
        annotation.title = "Destination"
        annotation.coordinate = CLLocationCoordinate2D(latitude: Double( tripSelected.end_lat)!, longitude:Double(tripSelected.end_long)!)
        myMap.addAnnotation(annotation)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0].coordinate)
        myMap.centerCoordinate = locations[0].coordinate
        print(locations[0].coordinate)
        currentLocation = locations[0].coordinate
        self.ref.child("users").child(Singleton.sharedInstance.loggedInDriver.first_name).setValue(["Name":
            Singleton.sharedInstance.loggedInDriver.first_name,"lat":currentLocation.latitude,"lon":currentLocation.longitude])

    }
    

    @IBAction func endTrip(_ sender: Any) {

        Networking.sharetInstance.updateTripStatus(id: tripSelected.id, status: TripState.completed.rawValue) { (valid, msg) in
            SwiftSpinner.hide()
            if valid{
                self.locationManager.stopUpdatingLocation()
                self.locationManager.stopUpdatingHeading()
                self.dismiss(animated: true, completion: nil)

            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }
        
    }

}



