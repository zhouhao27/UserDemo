//
//  LoginViewModel.swift
//  UserDemo
//
//  Created by Zhou Hao on 26/8/15.
//  Copyright © 2015 Zeus. All rights reserved.
//

import Foundation

class LoginViewModel {

    typealias LoginCallback = (user : User?, error : NSError?) -> Void
    
    func login(email : String, password : String, callback : LoginCallback) {
        
        // call service
        GCD.delay(2) { () -> () in
            
            if email == "a@a" && password == "password" {
                
                let user = User()
                user.email = email
                user.password = password
                user.gender = .Male
                user.age = 32
                
                callback(user: user, error: nil)
                
            } else {
                
                // TODO: Error code and description from server
                let error = NSError(domain: "com.wowtv", code: 1001, userInfo: [ NSLocalizedDescriptionKey : "Failed to login" ])
                callback(user: nil, error: error)
            }
        }
    }

}
