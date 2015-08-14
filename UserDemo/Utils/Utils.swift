//
//  Utils.swift
//  Flip
//
//  Created by Zhou Hao on 5/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import Foundation

class Utility {
    class func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    class func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    class func errorText(textField : UITextField) {
        
        let shake = POPSpringAnimation(propertyNamed: kPOPLayerPositionX)
        shake.springBounciness = 20
        shake.velocity = 3000
        
        textField.layer.pop_addAnimation(shake, forKey: "")
        
    }
}

/*
func springConstraint(constraint : NSLayoutConstraint, animationTo: CGFloat) -> POPSpringAnimation {
    
    let animation = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
    animation.toValue = animationTo
    animation.springBounciness = 10 // a float between 0 and 20
    animation.springSpeed = 6
    constraint.pop_addAnimation(animation, forKey: "")
    
    return animation
}
*/