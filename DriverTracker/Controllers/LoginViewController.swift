//
//  LoginViewController.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 12/5/18.
//  Copyright © 2018 Fatema El Zahraa. All rights reserved.
//

import UIKit
import Alamofire
import SCLAlertView
import SwiftSpinner

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let myColor : UIColor = UIColor.green
        usernameTxt.layer.borderColor = myColor.cgColor
        passwordTxt.layer.borderColor = myColor.cgColor
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        if usernameTxt.text == "" || passwordTxt.text == ""{
            SCLAlertView().showError("Error", subTitle: "Please fill in all the fields")
            return
        }
        SwiftSpinner.show("Connecting to server", animated: true)
        Networking.sharetInstance.login(username: usernameTxt.text!, password: passwordTxt.text!) { (valid, msg) in
            SwiftSpinner.hide()
            if valid{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let destinationVc = storyboard.instantiateViewController(withIdentifier: "tabController")
                UserDefaults.standard.set(true, forKey: "loggedIn")
                self.present(destinationVc, animated: true, completion: nil)
            }else{
                SCLAlertView().showError("Error", subTitle: msg)
            }
        }
        
    }
    
}
