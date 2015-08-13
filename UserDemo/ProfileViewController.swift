//
//  ProfileViewController.swift
//  Flip
//
//  Created by Zhou Hao on 5/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController,UserViewBehavior {

    @IBOutlet var logoutButton: ActionButton!
    var userDelegate : UserProtocol!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkTextColor().colorWithAlphaComponent(0.6)
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        
        // 1. validting
        
        // 2. login
        self.logoutButton.startAction()
        
        // simulate login success
        Utility.delay(1.0) { () -> () in
            self.logoutButton.finishActionAnimated(true, toView: self.view)
            self.userDelegate.onLogout()
        }
    }
}
