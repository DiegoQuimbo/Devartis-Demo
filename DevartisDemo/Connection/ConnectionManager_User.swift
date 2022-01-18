//
//  ConnectionManager_User.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import SwiftyJSON
import Alamofire

class ConnectionManager_User: ConnectionManager {
    
    class func register(user: String, password: String, completion :@escaping (_ success: Bool) -> ()) {
        
        let parameters = [
            "user": user.trimmingCharacters(in: .whitespaces),
            "password": password.trimmingCharacters(in: .whitespaces)
        ]
        
        AF.request(URLs.User.register, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ConnectionManager.headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    // Save Token
                    let dataJSON = JSON(data)
                    if let token = dataJSON["access_token"].string, let userID = dataJSON["user_id"].int {
                        sharedInstance.token = "Bearer \(token)"
                        SessionDataManager.sharedInstance.userLogged = User(id: userID)
                        completion(true)
                    } else {
                        // There is an error in the parse
                        completion(false)
                    }
                case .failure( _):
                    completion(false)
                }
            }
    }
    
    class func login(user: String, password: String, completion :@escaping (_ success: Bool) -> ()) {
        
        let parameters = [
            "user": user.trimmingCharacters(in: .whitespaces),
            "password": password.trimmingCharacters(in: .whitespaces)
        ]
        
        AF.request(URLs.User.login, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: ConnectionManager.headers)
            .validate()
            .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    // Save Token
                    let dataJSON = JSON(data)
                    if let token = dataJSON["access_token"].string, let userID = dataJSON["user_id"].int {
                        sharedInstance.token = "Bearer \(token)"
                        SessionDataManager.sharedInstance.userLogged = User(id: userID)
                        completion(true)
                    } else {
                        // There is an error in the parse
                        completion(false)
                    }
                case .failure( _):
                    completion(false)
                }
            }
    }
}
