//
//  UIViewController+ChildViewController.swift
//  WOWtouch
//
//  Enabled the AutoLayout
//
//  Created by Zhou Hao on 3/8/15.
//  Copyright © 2015 Zeus. All rights reserved.
//

import UIKit

extension UIViewController {

    func createChildViewController() -> UIViewController {

        let child = UIViewController()
        addSubViewController(child)
        return child
    }
    
    func createChildViewControllerWithIdentifier(identifier : String) -> UIViewController? {
        
        if self.storyboard != nil {
        
            let child = self.storyboard!.instantiateViewControllerWithIdentifier(identifier)
            addSubViewController(child)
            return child
            
        }
        return nil
    }
    
    func addSubViewController(viewController : UIViewController) {

        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(viewController.view)
        self.addChildViewController(viewController)
        viewController.didMoveToParentViewController(self)
    }
    
    func addAutolayoutFullyFilledView(view : UIView) {
        
        let views = ["view": view]
        let constraintH = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        let constraintV = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[view]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        self.view.addConstraints(constraintH)
        self.view.addConstraints(constraintV)
    }
    
    func removeSubViewController(viewController : UIViewController) {
        
        viewController.willMoveToParentViewController(nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()

    }

}
