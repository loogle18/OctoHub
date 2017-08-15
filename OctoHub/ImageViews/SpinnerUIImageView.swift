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
    
    init(x: CGFloat = 0, y: CGFloat = 0, size: CGFloat) {
        super.init(image: loadingImages.first)
        self.frame = CGRect(x: x, y: y, width: size / 3, height: size / 3)
        self.center = CGPoint(x: size / 2, y: size / 2)
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
