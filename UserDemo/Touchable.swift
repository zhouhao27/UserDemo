//
//  Touchable.swift
//  WOWtouch
//
//  Created by Zhou Hao on 01/08/15.
//  Copyright © 2015年 Zeus. All rights reserved.
//

import UIKit

@objc protocol Touchable {
    
    // local position in the Touchable view
    func allowPassThrough(position : CGPoint) -> Bool
}