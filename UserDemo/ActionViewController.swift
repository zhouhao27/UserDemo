//
//  ActionViewController.swift
//  WOWtouch
//
//  Created by Zhou Hao on 02/08/15.
//  Copyright © 2015年 Zeus. All rights reserved.
//

import UIKit

class ActionViewController: UIViewController,Touchable {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.darkTextColor().colorWithAlphaComponent(0.5)
    }

    func allowPassThrough(position : CGPoint) -> Bool {        
        return !CGRectContainsPoint(self.view.bounds, position)
    }
    
    // Need to overrides if needed
    func updateBottomMargin(margin : CGFloat) {
    }
    
    func reset() {
    }
    
    func hide(hide : Bool) {
        
    }
}
