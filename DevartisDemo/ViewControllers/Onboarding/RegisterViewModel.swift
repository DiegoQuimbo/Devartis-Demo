//
//  RegisterViewModel.swift
//  DevartisDemo
//
//  Created by Diego Quimbo on 4/22/21.
//

final class RegisterViewModel {
    
    // MARK: - Public Functions
    func userHasRegistered() -> Bool {
        return Utilities.userDidRegister()
    }
}

// MARK: - Call Network
extension RegisterViewModel {
    
    // Call Register service API
    func registerService(user: String, password: String, completion :@escaping (_ success: Bool) -> ()) {
        ConnectionManager_User.register(user: user, password: password) { success in
            if success {
                // Save in NSUserDefaults that the user has registered in order to avoid to show the register view in the next app init
                Utilities.saveUserDidRegister()
            }
            completion(success)
        }
    }
    
    func loginService(user: String, password: String, completion :@escaping (_ success: Bool) -> ()) {
        ConnectionManager_User.login(user: user, password: password) { success in
            completion(success)
        }
    }
    
}
