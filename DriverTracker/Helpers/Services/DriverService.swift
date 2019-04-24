//
//  DriverService.swift
//  DriverTracker
//
//  Created by Fatema El Zahraa on 11/30/18.
//  Copyright © 2018 Fatema El Zahraa. All rights reserved.
//

import Foundation
import Alamofire

extension Networking{
    func login(username: String, password: String, completed: @escaping (_ valid:Bool, _ msg:String)->()){
        let url = "\(Singleton.sharedInstance.serverBasePath)/login/driver"
        let parameters: Parameters = [
            "user_name" : username,
            "password" : password,
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
