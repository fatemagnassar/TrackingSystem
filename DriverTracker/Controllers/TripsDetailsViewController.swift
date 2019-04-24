//
//  TripsDetailsViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/10/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase
import SwiftSpinner
import SCLAlertView


class TripsDetailsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var tripSelected: Trips!

    @IBOutlet weak var tripstbl: UITableView!
    @IBOutlet weak var startTripBtn: UIButton!
    
    var infolbl: [String]!
    var tripinfo: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tripinfo = [tripSelected.trip_name,tripSelected.vehicle_name,tripSelected.date_time,tripSelected.estimated_time,tripSelected.destination_city_name , tripSelected.to_address,tripSelected.from_address,tripSelected.state]
        infolbl = ["Trip Name","Vehicle License","Date-Time"," Arrival Time", "City" ,"Source Address","Destination Address" ,"State"]
        tripstbl.reloadData()
        if tripSelected.state != TripState.notStarted.rawValue || Singleton.sharedInstance.flag==1 {
            startTripBtn.isHidden = true
        }
        else
        {
            startTripBtn.isHidden = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tripstbl.dequeueReusableCell(withIdentifier: "tripCell", for: indexPath)
        myCell.textLabel?.text = infolbl[indexPath.row]
        myCell.detailTextLabel?.text = tripinfo[indexPath.row]
        myCell.textLabel?.textColor = UIColor(red: 120/255.0, green: 150/255.0, blue: 200/255.0, alpha: 1)
        return myCell
        
    }

    @IBAction func startTrip(_ sender: Any) {
        Networking.sharetInstance.updateTripStatus(id: tripSelected.id, status: TripState.inprogress.rawValue) { (valid, msg) in
            SwiftSpinner.hide()
            if valid{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let destinationVc = storyboard.instantiateViewController(withIdentifier: "\(MapViewController.self)") as! MapViewController
                destinationVc.tripSelected = self.tripSelected
                self.present(destinationVc, animated: true, completion: nil)
               
            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }

        
        
    }
}
