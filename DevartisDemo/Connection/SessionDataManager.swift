//
//  SessionDataManager.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import Foundation

class SessionDataManager: NSObject {
    
    var userLogged: User? = nil
    
    /* SINGLETON */
    static let sharedInstance: SessionDataManager = {
        let instance = SessionDataManager()
        
        return instance
    }()
}
