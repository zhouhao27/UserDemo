//
//  ResetPasswordViewController.swift
//  UserDemo
//
//  Created by Zhou Hao on 14/8/15.
//  Copyright © 2015 Zeus. All rights reserved.
//

import UIKit

class ResetPasswordViewController: UIViewController,UserViewBehavior {
    
    var userDelegate : UserProtocol!
    
    @IBOutlet var resetButton: WOWCircleRippleButton!
    @IBOutlet var emailText: WOWTextField!
    @IBOutlet var messageLabel: WOWMessageLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailText.addTarget(self, action: "startEditing:", forControlEvents: .EditingChanged)
    }

    func reset() {
        
        emailText.text = ""
        messageLabel.errorMessage("")
        resetButton.reset()
    }
    
    @IBAction func onReset(sender: AnyObject) {
        
        // validate
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
        
        self.resetButton.startAction()
        Utility.delay(2.0) { () -> () in
            
            self.resetButton.stopAction(self.view, animated: true)
            self.userDelegate.onReset()
        }
        
    }

    @IBAction func onLogin(sender: AnyObject) {
        self.userDelegate.onSwitchToLoginFromResetPassword()
    }
    
    func startEditing(textField : UITextField) {
        
        if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            messageLabel.errorMessage("")
        }
    }
    
    // MARK: Implementation of UserBehavior protocol
    func activate() {
        
    }
    
    func deactivate() {
        
    }    
}
