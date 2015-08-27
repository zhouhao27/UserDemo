//
//  ProfileViewController.swift
//  Flip
//
//  Created by Zhou Hao on 5/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

class ProfileViewController: WOWAutolayoutScrollViewController,UserViewBehavior {

    var userDelegate : UserProtocol!
    @IBOutlet var logoutButton: WOWCircleRippleButton!
    @IBOutlet var saveButton: WOWCircleRippleButton!
    @IBOutlet var emailTextField: WOWTextField!
    @IBOutlet var nameTextField: WOWTextField!
    @IBOutlet var phoneNumberTextField: WOWTextField!
    @IBOutlet var genderSegment: UISegmentedControl!
    @IBOutlet var greetingLabel: UILabel!
    @IBOutlet var messageLabel: WOWMessageLabel!
    
    var viewModel : ProfileViewModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkTextColor().colorWithAlphaComponent(0.6)
    }
    
    // MARK: Implementation of UserBehavior protocol
    func activate() {
        
        self.viewModel = ProfileViewModel()
        
        setupInitialValues()
        setupLogoutButton()
        setupSaveButton()
        setupValidatingRules()
    }
    
    func deactivate() {

        self.viewModel = nil
    }
    
    func setupInitialValues() {
    
        self.emailTextField.enabled = false
        self.emailTextField.textFieldDidBeginEditing()
        
        self.viewModel?.name.observe({ (value : String?) -> () in
            
            if value != nil && value!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
                self.nameTextField.text = value!
                self.nameTextField.textFieldDidBeginEditing()
            }
        })
        
        self.viewModel?.phoneNumber.observe { (value : String?) -> () in

            if value != nil && value!.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
                self.phoneNumberTextField.text = value!
                self.phoneNumberTextField.textFieldDidBeginEditing()
            }
        }
        
        if self.viewModel?.gender.value == User.Gender.Male {
            self.genderSegment.selectedSegmentIndex = 0
        } else {
            self.genderSegment.selectedSegmentIndex = 1
        }
        
    }
    
    func setupValidatingRules() {
        
        self.nameTextField.bnd_text.map { "Hi," + $0! }
            .bindTo(greetingLabel.bnd_text)
        
        self.viewModel?.email.bidirectionalBindTo(emailTextField.bnd_text)
        self.viewModel?.name.bidirectionalBindTo(nameTextField.bnd_text)
        self.viewModel?.phoneNumber.bidirectionalBindTo(phoneNumberTextField.bnd_text)
    }
    
    func setupLogoutButton() {
        
        self.logoutButton.bnd_tap.observe { [unowned self] () -> () in
            
            self.logoutButton.startAction()
            self.viewModel!.logout({ [unowned self] (sucess, error) -> Void in
                
                self.logoutButton.stopAction(self.view, animated: true)
                if error != nil {
                    self.messageLabel.errorMessage(error!.localizedDescription)
                    self.logoutButton.reset()
                } else {
                    self.userDelegate.onLogout()
                }
            })
        }
    }
    
    func setupSaveButton() {
        
        self.saveButton.bnd_tap.observe { [unowned self] () -> () in
            
            self.saveButton.startAction()
            self.viewModel!.saveProfile { [unowned self] (sucess, error) -> Void in
             
                self.saveButton.stopAction(true)
                //self.saveButton.reset()
                if error != nil {
                    self.messageLabel.errorMessage(error!.localizedDescription)
                } else {
                    self.messageLabel.infoMessage("User profile saved.")
                }
            }
        }
    }
/*
    @IBAction func onLogout(sender: AnyObject) {
        
        self.logoutButton.startAction()

        // simulate login success
        Utility.delay(2.0) { () -> () in

            self.logoutButton.stopAction(self.view, animated: true)
            self.userDelegate.onLogout()
        }
    }
*/
    func reset() {
        logoutButton.reset()
        saveButton.reset()
    }
}
