//
//  LoginViewController.swift
//  Flip
//
//  Created by Zhou Hao on 5/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UserViewBehavior {

    var userDelegate : UserProtocol!
    
    @IBOutlet var loginButton: WOWCircleRippleButton!
    @IBOutlet weak var messageLabel: WOWMessageLabel!
    @IBOutlet weak var emailText: WOWTextField!
    @IBOutlet weak var passwordText: WOWTextField!
    
    var normalTextColor : UIColor!
    var normalButtonColor : UIColor!
    var loginViewModel : LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkTextColor().colorWithAlphaComponent(0.6)
    
        self.loginViewModel = LoginViewModel()
        self.normalTextColor = self.emailText.textColor
        self.normalButtonColor = self.loginButton.backgroundColor
        
        self.emailText.bnd_text.map {
            [unowned self] (value) -> UIColor in
            
            if value != nil {
                return Utility.isValidEmail(value!) ? self.normalTextColor : UIColor.redColor()
            } else {
                return self.normalTextColor
            }
            
        }.bindTo(self.emailText.bnd_textColor)
        
        self.passwordText.bnd_text.map {
            [unowned self] (value) -> UIColor in

            if value != nil {
                return self.isPasswordValid() ? self.normalTextColor : UIColor.redColor()
            } else {
                return self.normalTextColor
            }
            
        }.bindTo(self.passwordText.bnd_textColor)
        
        combineLatest(self.emailText.bnd_text, self.passwordText.bnd_text).observe {
            [unowned self] (email, password) -> () in
            
            if Utility.isValidEmail(email!) && self.isPasswordValid() {
                
                self.loginButton.backgroundColor = self.normalButtonColor
                self.loginButton.enabled = true
            } else {

                self.loginButton.backgroundColor = UIColor.lightGrayColor()
                self.loginButton.enabled = false
            }
        }
        
        self.loginButton.bnd_tap.observe {
            [unowned self] () -> () in
        
            self.view.endEditing(true)
            
            self.loginButton.startAction()
            
            // simulate login success
            self.loginViewModel.login(self.emailText.text!, password: self.passwordText.text!, callback: { (success, error) -> Void in
                
                self.loginButton.stopAction(self.view, animated: true)
                
                if error != nil {
                    self.messageLabel.errorMessage(error!.localizedDescription)
                    self.loginButton.reset()
                } else {
                    self.userDelegate.onLoginSuccess()
                }
            })
        }
        
    }

    @IBAction func onRegister(sender: AnyObject) {
        
        self.userDelegate.onSwitchToRegister()
    }
        
    @IBAction func onResetPassword(sender: AnyObject) {
        
        self.userDelegate.onSwitchToResetPassword()
    }
    
    // MARK: Implementation of UserBehavior protocol
    func activate() {
        
    }
    
    func deactivate() {
        
    }
    
    func reset() {
        
        emailText.text = ""
        passwordText.text = ""
        emailText.textFieldDidEndEditing()
        passwordText.textFieldDidEndEditing()
        loginButton.reset()
    }
    
    // TODO: in utility
    func isPasswordValid() -> Bool {
        return self.passwordText.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) >= 8
    }
        
}
