//
//  RestrictionDetailsViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 4/17/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit

class RestrictionDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource   {
    var resrictionSelected: Restriction!
    var infolbl: [String]!
    var resrictioninfo: [String]!
    @IBOutlet weak var resrictiontbl: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        fillArrays()
        resrictiontbl.reloadData()
        
    }
    fileprivate func fillArrays()
    {
        resrictioninfo = []
        infolbl = []
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = resrictiontbl.dequeueReusableCell(withIdentifier: "restdetailCell", for: indexPath)
        myCell.textLabel?.text = infolbl[indexPath.row]
        myCell.textLabel?.textColor = UIColor(red: 120/255.0, green: 150/255.0, blue: 200/255.0, alpha: 1)
        myCell.detailTextLabel?.text = resrictioninfo[indexPath.row]
        return myCell
        
    }
    
    @IBAction func viewbtn(_ sender: Any) {
        
    }
    

}
