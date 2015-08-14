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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onLogin(sender: AnyObject) {
        
        userDelegate.onSwitchToLoginFromResetPassword()
    }

}
