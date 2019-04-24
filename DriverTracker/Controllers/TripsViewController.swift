//
//  TripsViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/9/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit
import SwiftSpinner
import SCLAlertView

class TripsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tripstbl: UITableView!
    var shownTrips:[Trips] = [Trips]()
    
    @IBAction func currentbtn(_ sender: Any) {

        currenttrips()
    }
    
    @IBAction func previousbtn(_ sender: Any) {
        
        Networking.sharetInstance.retrieveTrips(id: Singleton.sharedInstance.loggedInDriver!.id, required: .completed) { (valid, msg, trips) in
            SwiftSpinner.hide()
            if valid{
                self.shownTrips=trips
                self.tripstbl.reloadData()

            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currenttrips()
    }
    
    fileprivate func currenttrips()
    {
        Networking.sharetInstance.retrieveTrips(id: Singleton.sharedInstance.loggedInDriver!.id, required: .notstarted) { (valid, msg, trips) in
            SwiftSpinner.hide()
            if valid{
                self.shownTrips=trips
                self.tripstbl.reloadData()
            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tripstbl.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath)
        myCell.textLabel?.text = shownTrips[indexPath.row].trip_name

        return myCell    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownTrips.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedTrip = self.shownTrips[(indexPath.row)]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVc = storyboard.instantiateViewController(withIdentifier: "\(TripsDetailsViewController.self)") as!TripsDetailsViewController
        
        destinationVc.tripSelected = selectedTrip
        navigationController?.pushViewController(destinationVc, animated: true)
        
    }
  
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
