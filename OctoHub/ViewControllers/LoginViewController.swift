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
    }
    @IBAction func signInAction() {
        let (isLoginValid, isPasswordValid) = (loginField.validate(), passwordField.validate())
    }
}
