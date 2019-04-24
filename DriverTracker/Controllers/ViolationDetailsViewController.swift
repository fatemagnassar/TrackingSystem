//
//  ViolationDetailsViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/15/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit
import SwiftSpinner
import SCLAlertView

class ViolationDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var violationSelected: Violation!
    var infolbl: [String]!
    var violationinfo: [String]!

    @IBOutlet weak var violationtbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = violationtbl.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
        myCell.textLabel?.text = infolbl[indexPath.row]
        myCell.textLabel?.textColor = UIColor(red: 120/255.0, green: 150/255.0, blue: 200/255.0, alpha: 1)

        myCell.detailTextLabel?.text = violationinfo[indexPath.row]
        return myCell
        
    }
    override func viewWillAppear(_ animated: Bool) {
        violationinfo = [violationSelected.date_time,violationSelected.trip_name,violationSelected.restriction_name]
        infolbl = ["Date Time","Trip","Restriction Type"]
        violationtbl.reloadData()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if infolbl [ (indexPath.row) ] == "Trip"
        {
            Networking.sharetInstance.getTrip(id: violationSelected.trip_id) { (valid, msg, retrievedTrip) in
                SwiftSpinner.hide()
                if valid{
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let destinationVc = storyboard.instantiateViewController(withIdentifier: "\(TripsDetailsViewController.self)") as!TripsDetailsViewController
                    
                    destinationVc.tripSelected = retrievedTrip
                    self.navigationController?.pushViewController(destinationVc, animated: true)
                }else{
                    SCLAlertView().showError("Error", subTitle: msg)
                }
            }
           
        }
      
        
    }
    


}
