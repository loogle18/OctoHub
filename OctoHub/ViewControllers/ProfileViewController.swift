//
//  ProfileViewController.swift
//  OctoHub
//
//  Created by Медведь Святослав on 02.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class ProfileViewController: ViewController {
    @IBOutlet weak var topProfileView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var userFollowersLabel: UILabel!
    @IBOutlet weak var userFollowingLabel: UILabel!
    @IBOutlet weak var topUserLoginConstraint: NSLayoutConstraint!
    @IBOutlet weak var userLabelHeightConstraint: NSLayoutConstraint!
    
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = self.navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.customBlue
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationBar.setValue(true, forKey: "hidesShadow")
        navigationBar.isTranslucent = false
        topProfileView.layer.backgroundColor = UIColor.customBlue.cgColor
        avatar.layer.cornerRadius = 20
        loadCurrentUser()
    }
    
    func loadCurrentUser() {
        GithubService(token).me() { response in
            switch response {
            case .success(let user):
                DispatchQueue.main.async {
                    self.userLoginLabel.text = user.login
                    self.userBioLabel.text = user.bio
                    self.avatar.image = user.avatar
                    self.userFollowersLabel.text = String(user.followers)
                    self.userFollowingLabel.text = String(user.following)
                    
                    if let userName = user.name {
                        self.userNameLabel.text = userName
                    } else {
                        self.topUserLoginConstraint.constant = 0
                        self.userLabelHeightConstraint.constant = 40
                        self.userNameLabel.frame.size.height = 0
                        self.userNameLabel.text = ""
                    }
                }
            case .failure(let error):
                self.showAlert(message: error)
            }
        }
    }
}
