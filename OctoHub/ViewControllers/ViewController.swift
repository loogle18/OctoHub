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
    var makeTransparentNavigationBar = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if makeTransparentNavigationBar, let navBar = self.navigationController?.navigationBar {
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.setValue(true, forKey: "hidesShadow")
        }
    }
    
    func showAlert(title: String = "Oops", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showActivityIndicator() {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let viewFrame = self.view.frame
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = viewFrame
        spinner = SpinnerUIImageView(parentWidth: viewFrame.width, parentHeight: viewFrame.height)
        
        blurEffectView.contentView.addSubview(spinner)
        
        if let navController = self.navigationController {
            navController.view.addSubview(blurEffectView)
        } else {
            self.view.addSubview(blurEffectView)
        }
        
        spinner.startAnimation()
    }
    
    func hideActivityIndicator() {
        blurEffectView.removeFromSuperview()
        spinner.stopAnimating()
    }
}
