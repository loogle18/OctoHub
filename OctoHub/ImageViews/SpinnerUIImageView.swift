//
//  SpinnerUIImageView.swift
//  OctoHub
//
//  Created by Медведь Святослав on 15.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class SpinnerUIImageView: UIImageView {
    let loadingImages = (0...8).map { UIImage(named: "spinner-set-\($0)")! }
    
    init(x: CGFloat = 0, y: CGFloat = 0, parentWidth: CGFloat, parentHeight: CGFloat) {
        super.init(image: loadingImages.first)
        self.frame = CGRect(x: x, y: y, width: 40, height: 40)
        self.center = CGPoint(x: parentWidth / 2, y: parentHeight / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func startAnimation() {
        self.animationImages = loadingImages
        self.animationDuration = 0.75
        self.startAnimating()
    }
}
