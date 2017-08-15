//
//  ViewController.swift
//  OctoHub
//
//  Created by Медведь Святослав on 14.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var blurEffectView: UIVisualEffectView!
    var spinner: SpinnerUIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String = "Oops", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.frame
        
        let spinnerWrapperView = UIView()
        let spinnerWrapperSize = CGFloat(120)
        
        spinnerWrapperView.frame = CGRect(x: 0.0, y: 0.0, width: spinnerWrapperSize, height: spinnerWrapperSize)
        spinnerWrapperView.center = CGPoint(x: blurEffectView.bounds.size.width / 2, y: blurEffectView.bounds.size.height / 2 - 44)
        spinnerWrapperView.backgroundColor = UIColor.white
        spinnerWrapperView.clipsToBounds = true
        spinnerWrapperView.layer.cornerRadius = 10
        
        spinner = SpinnerUIImageView(size: spinnerWrapperSize)
        
        spinnerWrapperView.addSubview(spinner)
        
        blurEffectView.contentView.addSubview(spinnerWrapperView)
        self.view.insertSubview(blurEffectView, at: 5)
        spinner.startAnimation()
    }
    
    func hideActivityIndicator() {
        blurEffectView.removeFromSuperview()
        spinner.stopAnimating()
    }
}
