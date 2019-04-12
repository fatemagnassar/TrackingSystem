//
//  PasswordEditViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 3/20/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import UIKit
import SwiftSpinner
import SCLAlertView
class PasswordEditViewController: UIViewController {

    @IBOutlet weak var newpwtxt: UITextField!
    @IBOutlet weak var oldpwtxt: UITextField!
    @IBAction func submitbtn(_ sender: Any) {
        if newpwtxt.text == "" || oldpwtxt.text == "" {
            SCLAlertView().showError("Error", subTitle: "Please fill in all the fields")
            return
        }
        Networking.sharetInstance.updatepassword(id: Singleton.sharedInstance.loggedInDriver!.id, oldpassword: oldpwtxt.text!, newpassword: newpwtxt.text!, email: Singleton.sharedInstance.loggedInDriver!.email) { (valid, msg) in
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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setToolbarHidden(false, animated: true)
        // Do any additional setup after loading the view.
        oldpwtxt.isSecureTextEntry=true
        newpwtxt.isSecureTextEntry=true
        
        
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
