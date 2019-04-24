//
//  ViolationViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/15/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit
import SCLAlertView
import SwiftSpinner

class ViolationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var shownViolations:[Violation] = [Violation]()

    @IBOutlet weak var violationstbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        retrieveViolation()
    }
    
    fileprivate func retrieveViolation()
    {
        Networking.sharetInstance.retrieveViolations(id: Singleton.sharedInstance.loggedInDriver!.driver_id) { (valid, msg, retrievedViolations) in
            SwiftSpinner.hide()
            if valid{
                self.shownViolations=retrievedViolations
                self.violationstbl.reloadData()
            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = violationstbl.dequeueReusableCell(withIdentifier: "violationCell", for: indexPath)
        myCell.textLabel?.text = shownViolations[indexPath.row].trip_name
    
        
        return myCell
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownViolations.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedviolation = shownViolations[(indexPath.row)]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVc = storyboard.instantiateViewController(withIdentifier: "\(ViolationDetailsViewController.self)") as!ViolationDetailsViewController
        
        destinationVc.violationSelected = selectedviolation
        navigationController?.pushViewController(destinationVc, animated: true)
        
    }
    
   

}
