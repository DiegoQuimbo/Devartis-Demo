//
//  ConnectionManager.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import Foundation
import Alamofire

class ConnectionManager: NSObject {
    
    var token = ""
    
    /* SINGLETON */
    static let sharedInstance: ConnectionManager = {
        let instance = ConnectionManager()
        
        return instance
    }()
    
    static let headers: HTTPHeaders = [
        .contentType("application/json"),
        .accept("application/json")
    ]
}
