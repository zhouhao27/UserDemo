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
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkTextColor().colorWithAlphaComponent(0.6)
        self.emailText.addTarget(self, action: "startEditing:", forControlEvents: .EditingChanged)
        self.passwordText.addTarget(self, action: "startEditing:", forControlEvents: .EditingChanged)
    }
    
    @IBAction func onLogin(sender: AnyObject) {
        
        // 1. validting
        if emailText.text == nil || emailText.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            
            Utility.errorText(emailText)
            messageLabel.errorMessage("Need email")
            return
        }
        
        if !Utility.isValidEmail(emailText.text!) {

            messageLabel.errorMessage("Invalid email")
            Utility.errorText(emailText)
            return
        }
        
        if passwordText.text == nil || passwordText.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {

            messageLabel.errorMessage("Need password")
            Utility.errorText(passwordText)
            return
        }
        
        self.view.endEditing(true)
        
        // 2. login
        self.loginButton.startAction()
        
        // simulate login success
        Utility.delay(2.0) { () -> () in
            
            self.loginButton.stopAction(self.view, animated: true)
            self.userDelegate.onLoginSuccess()
        }
    }
    
    @IBAction func onRegister(sender: AnyObject) {
        
        self.userDelegate.onSwitchToRegister()
    }
        
    @IBAction func onResetPassword(sender: AnyObject) {
        
        self.userDelegate.onSwitchToResetPassword()
    }
    
    // MARK: UITextField target
    func startEditing(textField : UITextField) {
        
        if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            messageLabel.errorMessage("")
        }
    }
    
    func reset() {
    
        emailText.text = ""
        passwordText.text = ""
        loginButton.reset()
    }
        
}
