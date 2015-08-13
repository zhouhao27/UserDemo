//
//  LoginViewController.swift
//  Flip
//
//  Created by Zhou Hao on 5/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController,UserViewBehavior {

    @IBOutlet var loginButton: ActionButton!
    var userDelegate : UserProtocol!
    
    @IBOutlet weak var messageLabel: UILabel!
//    @IBOutlet weak var emailText: UserInputTextField!
//    @IBOutlet weak var passwordText: UserInputTextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    // TODO: message flashing animation
    var message : String = "" {
        
        didSet {
            self.messageLabel.text = message
            
            let anim = POPSpringAnimation(propertyNamed: kPOPViewScaleY)
            anim.fromValue = NSValue(CGPoint: CGPointMake(1, 0.7))
            anim.toValue = NSValue(CGPoint: CGPointMake(1, 1))
            anim.springSpeed = 15
            anim.springBounciness = 10
            self.messageLabel.pop_addAnimation(anim, forKey: "")
            
            let anim2 = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            anim2.duration = 2.0
            anim2.fromValue = 0
            anim2.toValue = 1
            anim2.autoreverses = true
            anim2.repeatCount = 20
            self.messageLabel.pop_addAnimation(anim2, forKey: "")

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkTextColor().colorWithAlphaComponent(0.6)
        self.emailText.addTarget(self, action: "startEditing:", forControlEvents: .EditingChanged)
        self.passwordText.addTarget(self, action: "startEditing:", forControlEvents: .EditingChanged)
    }

    @IBAction func onLogin(sender: AnyObject) {
        
        // 1. validting
        if emailText.text == nil || emailText.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            
            errorText(emailText)
            message = "Need email"
            return
        }
        
        if !Utility.isValidEmail(emailText.text!) {
            
            message = "Invalid email"
            errorText(emailText)
            return
        }
        
        if passwordText.text == nil || passwordText.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 {
            
            message = "Need password"
            errorText(passwordText)
            return
        }
        
        self.view.endEditing(true)
        
        // 2. login
        self.loginButton.startAction()
        
        // simulate login success
        Utility.delay(2.0) { () -> () in
            self.loginButton.finishActionAnimated(true, toView: self.view)
            self.userDelegate.onLoginSuccess()
        }
    }
    
    @IBAction func onRegister(sender: AnyObject) {
        
        self.userDelegate.onSwitchToRegister()
    }
    
    func errorText(textField : UITextField) {
        
        let shake = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
        shake.springBounciness = 20
        shake.velocity = 3000
        
        textField.layer.pop_addAnimation(shake, forKey: "")
        
    }
    
    // MARK: UITextField target
    func startEditing(textField : UITextField) {
        
        if textField.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            self.message = ""
        }
    }    
        
}
