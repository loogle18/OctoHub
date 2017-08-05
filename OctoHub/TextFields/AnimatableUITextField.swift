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
        self.layer.borderColor = UIColor.customGray.cgColor
        self.layer.backgroundColor = UIColor.customLightGray.cgColor
        self.originPlaceholder = placeholder
        setOriginPlaceholder()
        delegate = self
        self.addTarget(self, action: #selector(AnimatableUITextField.textFieldChanged(_:)), for: UIControlEvents.editingChanged)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft,
                      y: bounds.origin.y,
                      width: bounds.size.width - paddingLeft - paddingRight,
                      height: bounds.size.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    func validate() -> Bool {
        var newPlaceholderText = originPlaceholder
        var isValid = true
        
        if ((self.text ?? "").isEmpty) {
            newPlaceholderText = originPlaceholder + " can't be blank"
            isValid = false
        }
        
        if (self.originPlaceholder == "Password" && self.text!.length < minimumPasswordLength) {
            isValid = false
            newPlaceholderText = "Password is too short (min. is \(minimumPasswordLength) characters)"
        }
        
        if (!isValid) {
            shake()
            self.text = ""
        }
        
        self.attributedPlaceholder = NSAttributedString(string: newPlaceholderText!,
                                                        attributes: [NSForegroundColorAttributeName: UIColor.customDarkGray])
        
        return isValid
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setOriginPlaceholder()
    }
    
    func textFieldChanged(_ textField: UITextField) {
        setOriginPlaceholder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    private func setOriginPlaceholder() {
        self.attributedPlaceholder = NSAttributedString(string: originPlaceholder,
                                                        attributes: [NSForegroundColorAttributeName: UIColor.customDarkGray])
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
