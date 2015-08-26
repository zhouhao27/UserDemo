//
//  LoginViewModel.swift
//  UserDemo
//
//  Created by Zhou Hao on 26/8/15.
//  Copyright © 2015 Zeus. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    func login(email : String, password : String, callback : UserManagementService.CompleteCallback) {
        
        UserManagementService.sharedInstance.login(email, password: password, callback: callback)
    }

}
