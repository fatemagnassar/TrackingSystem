//
//  EditService.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 3/20/19.
//  Copyright © 2019 Fatema El Zahraa. All rights reserved.
//

import Foundation
import Alamofire

extension Networking{
    
    func updateprofile(id:Int,username: String,firstname: String,lastname: String, email: String,address: String,phone: String, completed: @escaping (_ valid:Bool, _ msg:String)->()){
        let url = "\(Singleton.sharedInstance.serverBasePath)/UpdateUser2"
        let parameters: Parameters = [
            "id": id ,
            "user_name" : username,
            "first_name" : firstname,
            "last_name" : lastname,
            "email" : email,
            "address" : address,
            "phone" : phone,
            
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let valid = data["valid"] as! Bool
                if valid{
                    print("validdddddd")
                    
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: data["data"]!,options: []) {
                        guard let loggedInDriver = try? JSONDecoder().decode(Driver.self, from: theJSONData) else {
                            completed(false, "Unexpected Error Please Try Again In A While ")
                            return
                        }// convert driver jsondata to driver object w a7otaha f loggedindriver
                        Singleton.sharedInstance.loggedInDriver = loggedInDriver
                        completed(true,data["message"] as! String)
                        return
                    }
                }
                
                completed(false,data["message"] as! String)
            }else{
                print("mfish response ")
                
                completed(false, "Unexpected Error Please Try Again In A While ")
            }
        }
    }
    
    func updatepassword(id:Int,oldpassword: String,newpassword: String, email: String, completed: @escaping (_ valid:Bool, _ msg:String)->()){
        let url = "\(Singleton.sharedInstance.serverBasePath)/Updatepassword"
        let parameters: Parameters = [
            "id": id ,
            "email" : email,
            "oldpassword" : oldpassword,
            "newpassword" : newpassword,
            ]
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        Alamofire.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in
            if let jsonResponse = response.result.value{
                let data = jsonResponse as! [String : Any]
                let valid = data["valid"] as! Bool
                if valid{
                    print("validdddddd")
                    
                    if let theJSONData = try? JSONSerialization.data(withJSONObject: data["data"]!,options: []) {
                        guard let loggedInDriver = try? JSONDecoder().decode(Driver.self, from: theJSONData) else {
                            completed(false, "Unexpected Error Please Try Again In A While ")
                            return
                        }// convert driver jsondata to driver object w a7otaha f loggedindriver
                        Singleton.sharedInstance.loggedInDriver = loggedInDriver
                        completed(true,data["message"] as! String)
                        return
                    }
                }
                
                completed(false,data["message"] as! String)
            }else{
                print("mfish response ")
                
                completed(false, "Unexpected Error Please Try Again In A While ")
            }
        }
    }
}
