//
//  UIView+ViewController.swift
//  WOWtouch
//
//  Created by Zhou Hao on 01/08/15.
//  Copyright © 2015年 Zeus. All rights reserved.
//

import UIKit

extension UIView {
    
    func viewController() -> UIViewController? {

        if self.nextResponder()?.isKindOfClass(UIViewController) != nil {
            return self.nextResponder() as? UIViewController
        }

        return nil
    }
}