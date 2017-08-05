//
//  AnimatableUITextField.swift
//  OctoHub
//
//  Created by Медведь Святослав on 02.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class AnimatableUITextField: UITextField, UITextFieldDelegate {
    private let gorizontalPositionOffset = CGFloat(4)
    private let animationKey = "position"
    private var originPlaceholder: String!
    private let minimumPasswordLength = 7
    
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0
    
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)!
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.originPlaceholder = placeholder
        self.attributedPlaceholder = NSAttributedString(string: originPlaceholder, attributes: [NSForegroundColorAttributeName: UIColor.gray])
        
        delegate = self
        self.addTarget(self, action: #selector(AnimatableUITextField.textFieldChanged(_:)), for: UIControlEvents.editingChanged)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    func validate() -> Bool {
        if ((self.text ?? "").isEmpty) {
            shake()
            self.placeholder = originPlaceholder + " can't be blank"
            self.text = ""
            return false
        }
        
        if (self.originPlaceholder == "Password" && self.text!.length < minimumPasswordLength) {
            shake()
            self.placeholder = "Password is too short (min. is \(minimumPasswordLength) characters)"
            self.text = ""
            return false
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.placeholder = originPlaceholder
    }
    
    func textFieldChanged(_ textField: UITextField) {
        self.placeholder = originPlaceholder
    }

    private func shake() {
        let animation = CABasicAnimation(keyPath: animationKey)
        let (positionX, positionY) = (self.center.x, self.center.y)
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: positionX - gorizontalPositionOffset, y: positionY))
        animation.toValue = NSValue(cgPoint: CGPoint(x: positionX + gorizontalPositionOffset, y: positionY))
    
        self.layer.add(animation, forKey: animationKey)
    }
}
