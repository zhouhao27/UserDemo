//
//  RegisterViewController.swift
//  Flip
//
//  Created by Zhou Hao on 5/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UserViewBehavior {

    @IBOutlet var agreeCheckbox: WOWCheckbox!
    @IBOutlet var messageLabel: WOWMessageLabel!
    @IBOutlet var emailText: WOWTextField!
    @IBOutlet var passwordText: WOWTextField!
    @IBOutlet var confirmText: WOWTextField!
    @IBOutlet var registerButton: WOWCircleRippleButton!
    
    var userDelegate : UserProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.darkTextColor().colorWithAlphaComponent(0.6)
        
        self.emailText.addTarget(self, action: "startEditing:", forControlEvents: .EditingChanged)
        self.passwordText.addTarget(self, action: "startEditing:", forControlEvents: .EditingChanged)
        self.confirmText.addTarget(self, action: "startEditing:", forControlEvents: .EditingChanged)
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        self.userDelegate.onSwitchToLogin()
    }

    @IBAction func onRegister(sender: AnyObject) {
        
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
            
            Utility.errorText(emailText)
            messageLabel.errorMessage("Need password")
            return
        }
        
        if confirmText.text == nil || confirmText.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            
            Utility.errorText(emailText)
            messageLabel.errorMessage("Need password confirmation")
            return
        }
        
        if confirmText.text != passwordText.text {
            
            Utility.errorText(emailText)
            messageLabel.errorMessage("Password and confirmation doesn't match")
            return
        }
        
        if !agreeCheckbox.isChecked {
            // TODO: animation?
            messageLabel.errorMessage("Should agree terms and condition")
            return
        }
        
        // 2. login
        self.registerButton.startAction()
        
        Utility.delay(2.0) { () -> () in

            self.registerButton.stopAction(self.view, animated: true)
            self.userDelegate.onRegisterSuccess()
        }
        
    }
    
    // MARK: Implementation of UserBehavior protocol
    func activate() {
        
    }
    
    func deactivate() {
        
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
        confirmText.text = ""
        registerButton.reset()        
    }
    
}
