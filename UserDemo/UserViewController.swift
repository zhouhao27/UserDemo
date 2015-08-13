//
//  UserViewController.swift
//  Flip
//
//  Created by Zhou Hao on 5/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

protocol UserProtocol {
    
    func onSwitchToRegister()
    func onSwitchToLogin()
    func onLoginSuccess()
    func onRegisterSuccess()
    func onLogout()
}

protocol UserViewBehavior {
    var userDelegate : UserProtocol! { get set}
}

class UserViewController: ActionViewController, UserProtocol {

    var loginController     : LoginViewController!
    var registerController  : RegisterViewController!
    var profileController   : ProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerController.view.hidden = true
        self.profileController.view.hidden = true

        self.view.backgroundColor = UIColor.clearColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "LoginViewController" {
            
            self.loginController = segue.destinationViewController as! LoginViewController
            self.loginController.userDelegate = self
            
        } else if segue.identifier == "RegisterViewController" {
            
            self.registerController = segue.destinationViewController as! RegisterViewController
            self.registerController.userDelegate = self
            
        } else if segue.identifier == "ProfileViewController" {
            
            self.profileController = segue.destinationViewController as! ProfileViewController
            self.profileController.userDelegate = self
        }
    }
    
    func onSwitchToRegister() {
    
        self.registerController.view.hidden = false
        UIView.transitionFromView(self.loginController.view, toView: self.registerController.view, duration: 0.4, options: UIViewAnimationOptions([.TransitionFlipFromLeft,.CurveEaseInOut])) { (finished) -> Void in
            
            self.loginController.view.hidden = true
        }
    }
    
    func onSwitchToLogin() {
        
        self.loginController.view.hidden = false
        UIView.transitionFromView(self.registerController.view, toView: self.loginController.view, duration: 0.4, options: UIViewAnimationOptions([.TransitionFlipFromRight, .CurveEaseInOut])) { (finished) -> Void in
            
            self.registerController.view.hidden = true
        }
        
    }
    
    func onLoginSuccess() {

        let frame = self.profileController.view.frame
        self.profileController.view.hidden = false
        self.loginController.view.hidden = true
        self.profileController.view.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height)
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.profileController.view.frame = frame
            
        }) { (finished) -> Void in

        }

    }
    
    func onRegisterSuccess() {

        print("register successfully")
    }
    
    func onLogout() {
        
        let frame = self.loginController.view.frame
        self.loginController.view.hidden = false
        self.profileController.view.hidden = true
        self.loginController.view.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height)
        UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { () -> Void in
            self.loginController.view.frame = frame
        }) { (finished) -> Void in
                
        }        
        
    }
}
