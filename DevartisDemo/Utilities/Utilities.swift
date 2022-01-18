//
//  Utilities.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

import Foundation

class Utilities {
    enum DefaultSettings: String{
        case didRegister
    }
    
    class func saveUserDidRegister() {
        UserDefaults.standard.set(true, forKey: DefaultSettings.didRegister.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    class func userDidRegister() -> Bool {
        return UserDefaults.standard.bool(forKey: DefaultSettings.didRegister.rawValue)
    }
}
