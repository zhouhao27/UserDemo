//
//  RegisterViewController.swift
//  Flip
//
//  Created by Zhou Hao on 5/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UserViewBehavior {

    @IBOutlet var agreeCheckbox: Checkbox!
    @IBOutlet var registerButton: ActionButton!
    var userDelegate : UserProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.darkTextColor().colorWithAlphaComponent(0.6)
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        self.userDelegate.onSwitchToLogin()
    }

    @IBAction func onRegister(sender: AnyObject) {
        
        // 1. validting
        
        // 2. login
        self.registerButton.startAction()
        
        // simulate login success
        Utility.delay(2.0) { () -> () in

            self.registerButton.finishActionAnimated(true, toView: self.view)
            self.userDelegate.onRegisterSuccess()
        }
        
    }
}
