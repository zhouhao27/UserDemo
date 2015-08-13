//
//  PassthroughView.swift
//  Flip
//
//  Created by Zhou Hao on 05/08/15.
//  Copyright © 2015年 Zhou Hao. All rights reserved.
//

import UIKit

class PassThroughView: UIView {
    
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        
        for subview in subviews as [UIView] {
            if !subview.hidden && subview.alpha > 0 && subview.userInteractionEnabled && subview.pointInside(convertPoint(point, toView: subview), withEvent: event) {
                return true
            }
        }
        return false
    }
    
}