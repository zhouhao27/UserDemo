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
    func onSwitchToResetPassword()
    func onSwitchToLoginFromResetPassword()
    
    func onLoginSuccess()
    func onRegisterSuccess()
    func onLogout()
    func onReset()
    
}

protocol UserViewBehavior {
    var userDelegate : UserProtocol! { get set}
}

class UserViewController: ActionViewController, UserProtocol {

    var loginController         : LoginViewController!
    var registerController      : RegisterViewController!
    var profileController       : ProfileViewController!
    var resetPasswordController : ResetPasswordViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.registerController.view.alpha = 0
        self.profileController.view.alpha = 0
        self.resetPasswordController.view.alpha = 0

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
            
        } else if segue.identifier == "ResetPasswordViewController" {
            
            self.resetPasswordController = segue.destinationViewController as! ResetPasswordViewController
            self.resetPasswordController.userDelegate = self
            
        }
    }
    
    func onSwitchToRegister() {
    
        self.registerController.view.alpha = 1
        UIView.transitionFromView(self.loginController.view, toView: self.registerController.view, duration: 0.4, options: UIViewAnimationOptions([.TransitionFlipFromLeft,.CurveEaseInOut])) { (finished) -> Void in
            
            self.loginController.view.alpha = 0
        }
    }
    
    func onSwitchToLogin() {
        
        self.loginController.view.alpha = 1
        UIView.transitionFromView(self.registerController.view, toView: self.loginController.view, duration: 0.4, options: UIViewAnimationOptions([.TransitionFlipFromRight, .CurveEaseInOut])) { (finished) -> Void in
            
            self.registerController.view.alpha = 0
        }
        
    }
    
    func onLoginSuccess() {

        let frame = self.profileController.view.frame

        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
            self.profileController.view.alpha = 1
            self.loginController.view.alpha = 0
        }) { (finish) -> Void in

            // should reset login button size
            self.loginController.reset()
        }
        self.profileController.view.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height)
        UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.profileController.view.frame = frame
            
        }) { (finished) -> Void in
            
        }
    }
    
    func onRegisterSuccess() {

        // TODO: should use custom transtion animation
        UIView.transitionFromView(self.registerController.view, toView: self.loginController.view, duration: 0.0, options: UIViewAnimationOptions([.TransitionFlipFromRight, .CurveEaseInOut])) { (finished) -> Void in
            
            let frame = self.loginController.view.frame
            
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                self.loginController.view.alpha = 1
                self.registerController.view.alpha = 0
                }) { (finish) -> Void in
                    
                    self.registerController.reset()
            }
            self.loginController.view.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height)
            UIView.animateWithDuration(0.4, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { () -> Void in
                
                self.loginController.view.frame = frame
                
                }) { (finished) -> Void in
            }
        }
        
    }
    
    func onLogout() {
        
        let frame = self.loginController.view.frame
        
        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
        
            self.loginController.view.alpha = 1
            self.profileController.view.alpha = 0

        }) { (finish) -> Void in
                
            self.profileController.reset()
        }
        self.loginController.view.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height)
        UIView.animateWithDuration(0.4, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { () -> Void in
            self.loginController.view.frame = frame
        }) { (finished) -> Void in
                
        }
    }
    
    func onReset() {

        // TODO: custom transition animation
        UIView.transitionFromView(self.resetPasswordController.view, toView: self.loginController.view, duration: 0.0, options: UIViewAnimationOptions([.TransitionFlipFromRight, .CurveEaseInOut])) { (finished) -> Void in

            // return to login
            let frame = self.loginController.view.frame
            
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: { () -> Void in
                
                self.loginController.view.alpha = 1
                self.resetPasswordController.view.alpha = 0
                
                }) { (finish) -> Void in
                    
                    self.resetPasswordController.reset()
            }
            self.loginController.view.frame = CGRectMake(frame.origin.x, -frame.size.height, frame.size.width, frame.size.height)
            UIView.animateWithDuration(0.4, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .CurveEaseInOut, animations: { () -> Void in
                self.loginController.view.frame = frame
                }) { (finished) -> Void in
                    
            }
        }

    }
    
    func onSwitchToResetPassword() {
        
        self.resetPasswordController.view.alpha = 1
        UIView.transitionFromView(self.loginController.view, toView: self.resetPasswordController.view, duration: 0.4, options: UIViewAnimationOptions([.TransitionFlipFromLeft, .CurveEaseInOut])) { (finished) -> Void in
            
            self.loginController.view.alpha = 0
        }
        
    }
    
    func onSwitchToLoginFromResetPassword() {

        self.loginController.view.alpha = 1
        UIView.transitionFromView(self.resetPasswordController.view, toView: self.loginController.view, duration: 0.4, options: UIViewAnimationOptions([.TransitionFlipFromRight, .CurveEaseInOut])) { (finished) -> Void in
            
            self.resetPasswordController.view.alpha = 0
        }
        
    }
    
}
