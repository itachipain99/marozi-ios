//
//  CustomUIView.swift
//  Between
//
//  Created by Nguyễn Minh Hiếu on 2/14/20.
//  Copyright © 2020 Nguyễn Minh Hiếu. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUIView : UIView {
    private var _cornerRadius : CGFloat = 0.0
    private var _borderWith : CGFloat = 0.0
    private var _borderColor : UIColor = .clear
    @IBInspectable
    var _circle : Bool = false
    
    @IBInspectable
    var conerRadius : CGFloat {
        set (newValue) {
            _cornerRadius = newValue
            layer.cornerRadius = _cornerRadius
        }get{
            return _cornerRadius
        }
    }
    @IBInspectable
    var borderWith : CGFloat {
        set (newValue) {
            _borderWith = newValue
            layer.borderWidth = _borderWith
        }get{
            return _borderWith
        }
    }
    
    @IBInspectable
    var borderColor : UIColor {
        set (newValue) {
            _borderColor = newValue
            layer.borderColor = _borderColor.cgColor
        }get{
            return _borderColor
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if _circle {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.frame.width / 2
        }
    }
}
