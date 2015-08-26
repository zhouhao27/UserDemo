//
//  User.swift
//  UserDemo
//
//  Created by Zhou Hao on 26/8/15.
//  Copyright © 2015 Zeus. All rights reserved.
//

import Foundation

class User {
    
    enum Gender {
        case Male
        case Female
    }
    
    var name : String?
    var email : String?
    var password : String = ""
    var age : Int = 20
    var gender : Gender = .Male
    var phoneNumber : String?
    
}