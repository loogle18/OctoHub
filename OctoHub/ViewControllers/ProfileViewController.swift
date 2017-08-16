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
    @IBOutlet weak var userFollowersCountButton: UIButton!
    @IBOutlet weak var userFollowingCountButton: UIButton!
    @IBOutlet weak var userLoginTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var userLoginHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var userBioTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    
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
        showActivityIndicator()
        loadCurrentUserAndUpdateUI()
    }
    
    func loadCurrentUserAndUpdateUI() {
        GithubService(token).me() { response in
            switch response {
            case .success(let user):
                DispatchQueue.main.async {
                    self.userLoginLabel.text = user.login
                    self.avatar.image = user.avatar
                    self.userFollowersCountButton.setTitle(String(user.followers), for: .normal)
                    self.userFollowingCountButton.setTitle(String(user.following), for: .normal)
                    self.updateTopViewDataAndUI(userName: user.name, userBio: user.bio)
                    self.hideActivityIndicator()
                }
            case .failure(let error):
                self.hideActivityIndicator()
                self.showAlert(message: error)
            }
        }
    }
    
    private func updateTopViewDataAndUI(userName: String?, userBio: String?) {
        if let name = userName {
            userNameLabel.text = name
        } else {
            userLoginTopConstraint.constant = 0
            userLoginHeightConstraint.constant = 40
            userNameLabel.frame.size.height = 0
            userNameLabel.text = ""
        }
        
        if let bio = userBio {
            userBioLabel.text = bio
        } else {
            userBioLabel.frame.size.height = 0
            userBioTopConstraint.constant = 0
            userBioLabel.text = ""
        }
        
        userBioLabel.sizeToFit()
        topViewHeightConstraint.constant = 104 + userBioTopConstraint.constant + userBioLabel.frame.height
    }
}
