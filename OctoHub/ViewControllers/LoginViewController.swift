//
//  LoginViewController.swift
//  OctoHub
//
//  Created by Медведь Святослав on 02.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginField: AnimatableUITextField!
    @IBOutlet weak var passwordField: AnimatableUITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    var isStatusBarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.cornerRadius = 4
        signInButton.layer.backgroundColor = UIColor.customBlue.cgColor
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    @IBAction func signInAction() {
        let (isLoginValid, isPasswordValid) = (loginField.validate(), passwordField.validate())
        if (isLoginValid && isPasswordValid) {
            GithubService.createAuth(from: loginField.text!, and: passwordField.text!) { token in
                DispatchQueue.main.async {
                    let profileNVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileNVC") as! UINavigationController
                    let profileVC = profileNVC.topViewController as! ProfileViewController
                    profileVC.token = token
                    
                    self.present(profileNVC, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= signInButton.frame.height
            isStatusBarHidden = true
            UIView.animate(withDuration: 0.5) { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y += signInButton.frame.height
            isStatusBarHidden = false
            UIView.animate(withDuration: 0.5) { () -> Void in
                self.setNeedsStatusBarAppearanceUpdate()
            }
        }
    }
}
