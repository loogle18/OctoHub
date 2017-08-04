//
//  AnimatableUITextField.swift
//  OctoHub
//
//  Created by Медведь Святослав on 02.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class AnimatableUITextField: UITextField {
    private let gorizontalPositionOffset = CGFloat(4)
    private let animationKey = "position"
    
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.gray])
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    func shake() {
        let animation = CABasicAnimation(keyPath: animationKey)
        let (positionX, positionY) = (self.center.x, self.center.y)
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: positionX - gorizontalPositionOffset, y: positionY))
        animation.toValue = NSValue(cgPoint: CGPoint(x: positionX + gorizontalPositionOffset, y: positionY))
    
        self.layer.add(animation, forKey: animationKey)
    }
}
