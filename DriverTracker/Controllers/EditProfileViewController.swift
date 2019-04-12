//
//  EditProfileViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 3/20/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit
import SwiftSpinner
import SCLAlertView

class EditProfileViewController: UIViewController {

  
    @IBOutlet weak var usernametxt: UITextField!
    @IBOutlet weak var passwordtxt: UITextField!
    @IBOutlet weak var firstnametxt: UITextField!
    @IBOutlet weak var lastnametxt: UITextField!
    @IBOutlet weak var emailtxt: UITextField!
    @IBOutlet weak var addresstxt: UITextField!

    @IBOutlet weak var phonetxt: UITextField!
    
    override func viewDidLoad() {


        super.viewDidLoad()
        usernametxt.text=Singleton.sharedInstance.loggedInDriver!.user_name
        firstnametxt.text=Singleton.sharedInstance.loggedInDriver!.first_name
        lastnametxt.text=Singleton.sharedInstance.loggedInDriver!.last_name
        emailtxt.text=Singleton.sharedInstance.loggedInDriver!.email
        phonetxt.text=Singleton.sharedInstance.loggedInDriver!.phone
        addresstxt.text=Singleton.sharedInstance.loggedInDriver!.address
        //passwordtxt.text="********"

        // Do any additional setup after loading the view.
    }
    

    @IBAction func savebtn(_ sender: Any) {
        Networking.sharetInstance.updateprofile(id: Singleton.sharedInstance.loggedInDriver!.id, username: usernametxt.text!, firstname: firstnametxt.text!, lastname: lastnametxt.text!, email: emailtxt.text!, address: addresstxt.text!, phone: phonetxt.text!) { (valid, msg) in
            SwiftSpinner.hide()
            if valid{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                //let destinationVc = storyboard.instantiateViewController(withIdentifier: "tabController")
                
                let destinationVc = storyboard.instantiateViewController(withIdentifier: "profilepage")
                self.present(destinationVc, animated: true, completion: nil)
            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }
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
