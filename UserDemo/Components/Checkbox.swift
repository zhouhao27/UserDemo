//
//  Checkbox.swift
//  PentaGoMobile
//
//  Created by Ștefan Godoroja on 8/9/14..
//  Copyright (c) 2014 Ștefan Godoroja. All rights reserved.
//

import UIKit

// TODO: to make it designable in IB
// TODO: using CoreGraphic to draw so that I can change the color

protocol CheckboxDelegate {
    func didSelectCheckbox(checkbox : Checkbox)
}

class Checkbox : UIButton {
    
    var delegate: CheckboxDelegate?;
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        setup()
    }
    
    func setup() {
        
        let checkedImage = UIImage(named: "checked_checkbox")
        setImage(checkedImage, forState: .Selected)
        let uncheckedImage = UIImage(named: "unchecked_checkbox")
        setImage(uncheckedImage, forState: .Normal)
        
        self.addTarget(self, action: "onTouchUpInside:", forControlEvents: UIControlEvents.TouchUpInside);
    }
        
    func onTouchUpInside(sender: UIButton) {
        self.selected = !self.selected;
        delegate?.didSelectCheckbox(self)
    }
}