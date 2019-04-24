//
//  RestrictionsViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/17/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit
import SCLAlertView
import SwiftSpinner

class RestrictionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var restrictionstbl: UITableView!
    var restrictions:[Restriction] = [Restriction]()
    var group_id : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restrictions.count
    }
    override func viewWillAppear(_ animated: Bool) {
       retrieveRestrictions()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = restrictionstbl.dequeueReusableCell(withIdentifier: "RestrictionCell", for: indexPath)
       myCell.textLabel?.text = restrictions[indexPath.row].name
 
        return myCell
        
    }
    fileprivate func retrieveRestrictions()
    {
        Networking.sharetInstance.retrieveRestrictions(id: group_id!) { (valid, msg, retrievedrestrictions) in
            SwiftSpinner.hide()
            if valid{
                self.restrictions = retrievedrestrictions
                self.restrictionstbl.reloadData()
            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVc = storyboard.instantiateViewController(withIdentifier: "\(RestrictionDetailsViewController.self)") as!RestrictionDetailsViewController
        
        destinationVc.resrictionSelected = restrictions[indexPath.row]
        self.navigationController?.pushViewController(destinationVc, animated: true)
        
    }
    

    

}
