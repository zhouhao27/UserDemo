//
//  ActionButton.swift
//  MorphButton
//
//  Created by Zhou Hao on 07/08/15.
//  Copyright © 2015年 Zeus. All rights reserved.
//

import UIKit

// TODO: add a reset animation to reset to it's original status
@IBDesignable
public class ActionButton: UIButton {

    let kIndicatorMargin                    : CGFloat = 2.0
    
    private var actionInProgress            : Bool = false
    private var originalCornerRadius        : CGFloat = 0
    
    @IBInspectable private var indicator    : MRActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // TODO: assume width > height, if not?     
        let indicatorWidth = self.frame.size.height - 2 * kIndicatorMargin
        let frame = CGRectMake((self.frame.size.width - indicatorWidth)/2, kIndicatorMargin, indicatorWidth, indicatorWidth)
        originalCornerRadius = self.cornerRadius

        indicator.frame = frame
    }
    

    @IBInspectable var indicatorColor : UIColor = UIColor.whiteColor() {
        didSet {
            indicator.tintColor = indicatorColor
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    
    private func setup() {
        
        indicator = MRActivityIndicatorView()
        indicator.hidden = !actionInProgress
        indicator.lineWidth = 0.5
        addSubview(indicator)
    }
    
    public func startAction() {
        
        if !actionInProgress {

            self.layer.cornerRadius = self.frame.size.height / CGFloat(2.0)
            self.setTitleColor(UIColor.clearColor(), forState: .Normal)
            
            let anim = POPSpringAnimation(propertyNamed: kPOPViewBounds)
            anim.toValue = NSValue(CGRect: CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height))
            anim.springSpeed = 20
            anim.springBounciness = 10
            anim.completionBlock = {
                (animation , finished) in
            }
            self.pop_addAnimation(anim, forKey: "morph")
            
            actionInProgress = true
            indicator.hidden = false
            indicator.startAnimating()
                        
        }
    }
    
    public func finishActionAnimated(animated : Bool, toView : UIView, onAnimationApplied : (() -> Void), onAnimationComplete: (() -> Void)) {
        
        if actionInProgress {
            
            indicator.stopAnimating()
            indicator.hidden = true
            actionInProgress = false
            
            if animated {
                
                toView.clipsToBounds = true // don't allow the subview out of the boundary
                
                layer.cornerRadius = 0
                
                let anim = POPSpringAnimation(propertyNamed: kPOPViewBounds)
                anim.toValue = NSValue(CGRect: toView.bounds)
                anim.springSpeed = 20
                anim.springBounciness = 10
                self.pop_addAnimation(anim, forKey: "zooming")
                
                Utility.delay(0.2, closure: { () -> () in
                    let anim2 = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
                    anim2.toValue = 0
                    anim2.duration = 0.4
                    toView.pop_addAnimation(anim2, forKey: "fadeout")
                })
                
                anim.animationDidStartBlock = {
                    animation in

                    onAnimationApplied()                    
                }
                
                anim.completionBlock = {
                    (animation,finished) in
                    
                    onAnimationComplete()
                }
                
            }
        }
        
    }
    
    public func finishActionAnimated(animated : Bool, toView : UIView) {
        
        if actionInProgress {
        
            indicator.stopAnimating()
            indicator.hidden = true
            actionInProgress = false
            
            if animated {

                toView.clipsToBounds = true // don't allow the subview out of the boundary
                
                let anim = POPSpringAnimation(propertyNamed: kPOPViewScaleXY)
                let scale = max(toView.bounds.width / self.bounds.width, toView.bounds.height / self.bounds.width)
                anim.toValue = NSValue(CGPoint: CGPointMake(scale, scale))
                anim.springSpeed = 20
                anim.springBounciness = 10
                self.pop_addAnimation(anim, forKey: "zooming")
                
                Utility.delay(0.0, closure: { () -> () in
                    let anim2 = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
                    anim2.toValue = 0
                    
                    toView.pop_addAnimation(anim2, forKey: "fadeout")
                })
                
//                anim.completionBlock = {
//                    (animation,finished) in
//                }

            }
        }
    }
}
