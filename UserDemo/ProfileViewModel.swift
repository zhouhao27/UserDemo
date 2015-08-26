//
//  ProfileViewModel.swift
//  UserDemo
//
//  Created by Zhou Hao on 26/8/15.
//  Copyright © 2015 Zeus. All rights reserved.
//

import Foundation

class ProfileViewModel {
    
    var name : Observable<String?>
    var email : Observable<String?>
    var gender : Observable<User.Gender?>
    var phoneNumber : Observable<String?>
    var age : Observable<Int?>
    
    init() {
        
        // populate it from current user
        let user = UserManagementService.sharedInstance.currentUser
        self.name = Observable(user?.name)
        self.name.observe { (value) -> () in
            user?.name = value
        }
        
        self.email = Observable(user?.email)
        
        self.gender = Observable(user?.gender)
        self.gender.observe { (value) -> () in
            user?.gender = value!
        }
        self.age = Observable(user?.age)
        self.age.observe { (value) -> () in
            user?.age = value!
        }
        
        self.phoneNumber = Observable(user?.phoneNumber)
        self.phoneNumber.observe { (number) -> () in
            user?.phoneNumber = number
        }
    }
    
    func logout(complete : UserManagementService.CompleteCallback) {
        
        UserManagementService.sharedInstance.logout(complete)
    }
    
    func saveProfile(complete: UserManagementService.CompleteCallback) {
        
        UserManagementService.sharedInstance.saveProfile(complete)
    }
}