//
//  WOWAutolayoutScrollViewController.swift
//  AutoScrollview
//
//  The View Controller must includes a UIScrollView and a ContentView inside the scroll view
//
//  Procedures to create Autolayout for UIScrollView:
//  1. Create top, bottom, trailing, leading constraints for UIScrollView
//  2. Add a UIView as Content View to UIScrollView
//  3. Add top, bottom, trailing, leading constraints for Content view
//     - The bottom constants may be something like 200 ect. Don't use 0
//     - Change the bottom constant value to zero so that there will be some constraints conflict for this
//  4. Add a constraints that Content view width equal to the UIScrollView's parent width
//  5. Add controls to the Content view, and add constraints
//     - The very bottom control's top, bottom constraints must be set
//
//  Created by Zhou Hao on 26/08/15.
//  Copyright © 2015年 Zeus. All rights reserved.
//

import UIKit

class WOWAutolayoutScrollViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    var activeTextField : UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardDidShow:" , name: UIKeyboardDidShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillBeHidden:" , name: UIKeyboardWillHideNotification, object: nil)
        
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)        
    }
    
    func textFieldShouldReturn(textField : UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidBeginEditing(sender : UITextField) {
        
        self.activeTextField = sender
    }
    
    func textFieldDidEndEditing(sender : UITextField) {
        self.activeTextField = nil
    }
    
    func keyboardDidShow(notification : NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            let kbRect = self.view.convertRect(keyboardSize, fromView: nil)
            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0)
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect = self.view.frame
            aRect.size.height -= kbRect.size.height
            
            if self.activeTextField != nil && !CGRectContainsPoint(aRect, self.activeTextField!.frame.origin)  {
                self.scrollView.scrollRectToVisible(self.activeTextField!.frame, animated: true)
            }
        }

    }
    
    func keyboardWillBeHidden(notification : NSNotification) {
    
        let contentInsets = UIEdgeInsetsZero
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
}

