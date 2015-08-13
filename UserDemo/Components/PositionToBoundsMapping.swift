//
//  PositionToBoundsMapping.swift
//  Flip
//
//  Created by Zhou Hao on 5/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

//! A derivative of the UIDynamicItem protocol that requires objects adopting it
//! to expose a mutable bounds property.
//protocol ResizableDynamicItem : UIDynamicItem {
//    var bounds:CGRect{ get set }
//}

class PositionToBoundsMapping: NSObject, UIDynamicItem
{

    //    var center: CGPoint { get set }
    //    var bounds: CGRect { get }
    //    var transform: CGAffineTransform { get set }
    
    //var target : ResizableDynamicItem
    var target : UIView
    
    //| ----------------------------------------------------------------------------
    init(target: UIView) {
        self.target = target
    }

    //#pragma mark -
    //#pragma mark UIDynamicItem
    
    //| ----------------------------------------------------------------------------
    //  Manual implementation of the getter for the bounds property required by
    //  UIDynamicItem.
    //
    var bounds : CGRect {
        get {
            return self.target.bounds
        }
    }
    
    var center : CGPoint {
        //| ----------------------------------------------------------------------------
        //  Manual implementation of the getter for the center property required by
        //  UIDynamicItem.
        //
        get {
            // center.x <- bounds.size.width, center.y <- bounds.size.height
            return CGPointMake(self.target.bounds.size.width, self.target.bounds.size.height)
        }
    
        //| ----------------------------------------------------------------------------
        //  Manual implementation of the setter for the center property required by
        //  UIDynamicItem.
        //
        set (newCenter) {
            // center.x -> bounds.size.width, center.y -> bounds.size.height
            self.target.bounds = CGRectMake(0, 0, newCenter.x, newCenter.y)
        }
    }

    var transform : CGAffineTransform {
        //| ----------------------------------------------------------------------------
        //  Manual implementation of the getter for the transform property required by
        //  UIDynamicItem.
        //
        get {
            return self.target.transform
        }

        //| ----------------------------------------------------------------------------
        //  Manual implementation of the setter for the transform property required by
        //  UIDynamicItem.
        //
        set (newTransform) {
    
            self.target.transform = newTransform
        }
    }
}
