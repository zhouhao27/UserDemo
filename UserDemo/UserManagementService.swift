//
//  UserManagementService.swift
//  UserDemo
//
//  Created by Zhou Hao on 26/8/15.
//  Copyright © 2015 Zeus. All rights reserved.
//

import Foundation

class UserManagementService {
    
    typealias CompleteCallback = (sucess : Bool, error : NSError?) -> Void
    
    class var sharedInstance : UserManagementService {
        
        struct Static {
            static let instance = UserManagementService()
        }
        return Static.instance        
    }
    
    var currentUser : User?
    var bnd_user : Observable<User>?
    
    func login(email : String, password : String, callback : CompleteCallback) {
        
        // call service
        GCD.delay(2) { () -> () in
            
            if email == "a@a" && password == "password" {
                
                if self.currentUser == nil {
                    let user = User()
                    user.email = email
                    user.password = password
                    user.name = "Zhou"
                    user.gender = .Female
                    user.age = 32
                    self.currentUser = user                    
                }
                callback(sucess: true, error: nil)
                
            } else {
                
                // TODO: Error code and description from server
                let error = NSError(domain: "com.wowtv", code: 1001, userInfo: [ NSLocalizedDescriptionKey : "Failed to login" ])
                callback(sucess: false, error: error)
            }
        }
        
    }
    
    func logout(complete : UserManagementService.CompleteCallback) {
        
        Utility.delay(2.0) { () -> () in
            
            self.currentUser = nil
            // TODO: ...
            
            complete(sucess: true, error: nil)
        }
    }
    
    func resetPassword() {
        
    }
    
    func register() {
        
    }
    
    // save current user profile
    func saveProfile(complete: CompleteCallback) {
        
//        print(UserManagementService.sharedInstance.currentUser?.phoneNumber)
        
        Utility.delay(2.0) { () -> () in
            
            complete(sucess: true,error: nil)
        }
    }
}