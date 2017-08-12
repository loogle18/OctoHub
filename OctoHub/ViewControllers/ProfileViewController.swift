//
//  ProfileViewController.swift
//  OctoHub
//
//  Created by Медведь Святослав on 02.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var topProfileView: UIView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userLoginLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = self.navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.customBlue
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBar.setValue(true, forKey: "hidesShadow")
        navigationBar.isTranslucent = false
        topProfileView.layer.backgroundColor = UIColor.customBlue.cgColor
        avatar.layer.cornerRadius = 40
        loadCurrentUser()
    }
    
    func loadCurrentUser() {
        GithubService(token).me() { response in
            switch response {
            case .success(let user):
                DispatchQueue.main.async {
                    self.userNameLabel.text = user.name
                    self.userLoginLabel.text = user.login
                    self.userEmailLabel.text = user.email
                    self.avatar.image = user.avatar
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
