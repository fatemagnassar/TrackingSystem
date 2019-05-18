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
import BRYXBanner

enum GeofenceType {
    case line
    case polygon
    case circle
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    var tripSelected: Trips!
    var banner : Banner?
    var ref: DatabaseReference!
    @IBOutlet weak var myMap: MKMapView!
    @IBOutlet weak var maxSpeedLabel: UILabel!
    var locationManager: CLLocationManager!
    var currentLocation: CLLocationCoordinate2D!
    var geofences: [Geofence] = []
    var inGeofence = false
    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.sharetInstance.retrieveGeofences(id: tripSelected.id) { (valid, msg, geofences) in
            self.geofences = geofences
            for geofence in geofences {
                if geofence.type == .circle {
                    self.addCircle(center: geofence.center, radius: geofence.radius)
                } else {
                    self.addOverLay(points: geofence.points)
                }
            }
        }
        setupLocation()
        mapSetup()
        maxSpeedLabel.text = "100"
        ref = Database.database().reference()
        let annotationdest = MKPointAnnotation()
        annotationdest.title = "Your Destination"
        //annotationdest.coordinate = CLLocationCoordinate2D(latitude: Double( tripSelected.end_lat)!, longitude:Double(tripSelected.end_long)!)
        myMap.addAnnotation(annotationdest)
        let annotationstart = MKPointAnnotation()
        annotationstart.title = "Your Pickup"
        //annotationstart.coordinate = CLLocationCoordinate2D(latitude: Double( tripSelected.start_lat)!, longitude:Double(tripSelected.start_long)!)
        myMap.addAnnotation(annotationstart)
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
        myMap.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0].coordinate)
        centerMapOnLocation(location: locations[0])
        print(locations[0].coordinate)
        currentLocation = locations[0].coordinate
        var violation = false
        if !inGeofence {
            inGeofence = true
            //TODO report violation to backend
            for geofence in geofences {
                if geofence.type == .circle {
                    let circleRenderer = MKCircleRenderer(circle: MKCircle(center: geofence.center, radius: geofence.radius))
                    let mapPoint: MKMapPoint = MKMapPoint(currentLocation)
                    let circleViewPoint: CGPoint = circleRenderer.point(for: mapPoint)
                    if circleRenderer.path.contains(circleViewPoint) {
                        showBanner()
                        violation = true
                    }
                } else {
                    if geofence.points.count > 2 {
                        let polygonRenderer = MKPolygonRenderer(polygon: MKPolygon(coordinates: geofence.points, count: geofence.points.count))
                        let mapPoint: MKMapPoint = MKMapPoint(currentLocation)
                        let polygonViewPoint: CGPoint = polygonRenderer.point(for: mapPoint)
                        if polygonRenderer.path.contains(polygonViewPoint) {
                            showBanner()
                            violation = true
                        }
                    }
                }
            }
            if !violation {
                inGeofence = false
                hideBanner()
            }
        }
        self.ref.child("users").child(Singleton.sharedInstance.loggedInDriver.first_name).setValue(["Name":
            Singleton.sharedInstance.loggedInDriver.first_name,"lat":currentLocation.latitude,"lon":currentLocation.longitude])
    }
    
    func showBanner() {
        banner?.dismiss()
        banner = Banner(title: "Warning", subtitle: "You have entered a restricted area", backgroundColor: UIColor(red:1, green:0, blue:0, alpha:1))
        banner?.dismissesOnTap = false
        banner?.show()
    }
    
    func hideBanner() {
        banner?.dismiss()
    }
    

    @IBAction func endTrip(_ sender: Any) {

        Networking.sharetInstance.updateTripStatus(id: tripSelected.id, status: TripState.finished.rawValue) { (valid, msg) in
            SwiftSpinner.hide()
            if valid{
                self.locationManager.stopUpdatingLocation()
                self.locationManager.stopUpdatingHeading()
                self.dismiss(animated: true, completion: nil)
                Singleton.sharedInstance.flag=1
            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }
        
    }
    func addOverLay(points: [CLLocationCoordinate2D])
    {
        let overlay = MKPolygon(coordinates: points, count: points.count)
        myMap.addOverlay(overlay)
    }
    
    func addCircle(center: CLLocationCoordinate2D, radius: CLLocationDistance) {
        let circle = MKCircle(center: center, radius: radius)
        myMap.addOverlay(circle)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        myMap.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.blue
            
            return polygonView
        }
        if overlay is MKPolyline {
            let lineView = MKPolylineRenderer(overlay: overlay)
            lineView.strokeColor = UIColor.blue
            return lineView
        }
        if overlay is MKCircle {
            let circleView = MKCircleRenderer(overlay: overlay)
            circleView.strokeColor = UIColor.blue
            circleView.lineWidth = 1
            circleView.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.3)
            return circleView
        }
        return MKOverlayRenderer()
        
    }
}








