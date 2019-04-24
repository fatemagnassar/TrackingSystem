//
//  GroupsViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/17/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit
import SCLAlertView
import SwiftSpinner

class GroupsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource  {
    var groups:[Group] = [Group]()

    @IBOutlet weak var groupstbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = groupstbl.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        myCell.textLabel?.text = groups[indexPath.row].name
        
        return myCell
        
    }
    override func viewWillAppear(_ animated: Bool) {
        retrieveGroups()
    }
    fileprivate func retrieveGroups()
    {
        Networking.sharetInstance.retrieveGroups(id: Singleton.sharedInstance.loggedInDriver.driver_id) { (valid, msg, grouparr) in
            SwiftSpinner.hide()
            if valid{
                self.groups = grouparr
                self.groupstbl.reloadData()
            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }
    }
    
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVc = storyboard.instantiateViewController(withIdentifier: "\(RestrictionsViewController.self)") as!RestrictionsViewController
        
        destinationVc.group_id = groups[indexPath.row].id
        self.navigationController?.pushViewController(destinationVc, animated: true)
        
            }
            
        

}
