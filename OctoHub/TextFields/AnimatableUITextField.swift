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
