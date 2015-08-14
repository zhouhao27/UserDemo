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
            
            let anim = POPSpringAnimation(propertyNamed: kPOPViewScaleY)
            anim.fromValue = NSValue(CGPoint: CGPointMake(1, 0.7))
            anim.toValue = NSValue(CGPoint: CGPointMake(1, 1))
            anim.springSpeed = 15
            anim.springBounciness = 10
            self.pop_addAnimation(anim, forKey: "")
            
            let anim2 = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
            anim2.duration = 2.0
            anim2.fromValue = 0
            anim2.toValue = 1
//            anim2.autoreverses = true
//            anim2.repeatCount = 20
            self.pop_addAnimation(anim2, forKey: "")
            
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
