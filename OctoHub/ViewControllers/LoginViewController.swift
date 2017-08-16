//
//  LoginViewController.swift
//  OctoHub
//
//  Created by Медведь Святослав on 02.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {
    @IBOutlet weak var loginField: AnimatableUITextField!
    @IBOutlet weak var passwordField: AnimatableUITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    
    var isStatusBarHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.cornerRadius = 4
        signInButton.layer.backgroundColor = UIColor.customBlue.cgColor
        orLabel.textColor = UIColor.customDarkGray
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShow),
                                               name: NSNotification.Name.UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHide),
                                               name: NSNotification.Name.UIKeyboardWillHide,
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.makeTransparentNavigationBar = true
        
        super.viewWillAppear(animated)
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
            GithubService.createAuth(from: loginField.text!, and: passwordField.text!) { response in
                DispatchQueue.main.async {
                    switch response {
                    case .success(let token):
                        let profileNVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileNVC") as! UINavigationController
                        let profileVC = profileNVC.topViewController as! ProfileViewController
                        profileVC.token = token
                    
                        self.present(profileNVC, animated: true, completion: nil)
                    case .failure(let error):
                        self.showAlert(message: error)
                    }
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
