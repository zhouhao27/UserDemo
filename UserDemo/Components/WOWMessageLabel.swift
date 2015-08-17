//
//  WOWMessageLabel.swift
//  UserDemo
//
//  Created by Zhou Hao on 14/8/15.
//  Copyright © 2015 Zeus. All rights reserved.
//

import UIKit

@IBDesignable
class WOWMessageLabel: UILabel {

    enum MessageType {
        case info
        case warning
        case error
    }
    
    // MARK: inspectable
    @IBInspectable var errorColor : UIColor = UIColor.redColor()
    @IBInspectable var warningColor : UIColor = UIColor.orangeColor()
    @IBInspectable var infoColor : UIColor = UIColor.whiteColor()
    
    var type : MessageType = .info
    
    var message : String = "" {
    
        didSet {
            
            self.text = message
            self.sizeToFit()
            
            self.alpha = 0
            UIView.animateWithDuration(0.4) { () -> Void in
                self.alpha = 1
            }
            
            if type == .error {
                self.textColor = errorColor
            } else if type == .warning {
                self.textColor = warningColor
            } else if type == .info {
                self.textColor = infoColor
            }
            
        }
    }
    
    func errorMessage(message : String) {
        
        self.type = .error
        self.message = message
    }
    
    func warningMessage(message : String) {

        self.type = .warning
        self.message = message
        
    }
    
    func infoMessage(message : String) {
        
        self.type = .info
        self.message = message
        
    }
    
}
