//
//  ProfileViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 3/17/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//
import UIKit
import Foundation
class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var profiletbl: UITableView!
    @IBOutlet weak var profilePicIcon: UIImageView!
    var infolbl: [String]!
    var driverinfo: [String]!

    
    @IBAction func logOut(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "loggedIn")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        infolbl = ["Username","First name", "Last name", "Email" , "Phone" ,"Address"]
        driverinfo = [Singleton.sharedInstance.loggedInDriver!.user_name,Singleton.sharedInstance.loggedInDriver!.first_name, Singleton.sharedInstance.loggedInDriver!.last_name, Singleton.sharedInstance.loggedInDriver!.email,Singleton.sharedInstance.loggedInDriver!.phone,Singleton.sharedInstance.loggedInDriver!.address]
        profiletbl.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        infolbl = ["Username","First name", "Last name", "Email" , "Phone" ,"Address"]
        driverinfo = [Singleton.sharedInstance.loggedInDriver!.user_name,Singleton.sharedInstance.loggedInDriver!.first_name, Singleton.sharedInstance.loggedInDriver!.last_name, Singleton.sharedInstance.loggedInDriver!.email,Singleton.sharedInstance.loggedInDriver!.phone,Singleton.sharedInstance.loggedInDriver!.address]
        profiletbl.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = profiletbl.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
        myCell.textLabel?.text = infolbl[indexPath.row]
        myCell.textLabel?.textColor = UIColor(red: 120/255.0, green: 150/255.0, blue: 200/255.0, alpha: 1)

        myCell.detailTextLabel?.text = driverinfo[indexPath.row]
        return myCell
    }
    
}
