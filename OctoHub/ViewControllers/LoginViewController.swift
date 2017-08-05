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
    
    @IBAction func signInAction() {
        let (isLoginValid, isPasswordValid) = (loginField.validate(), passwordField.validate())
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}
