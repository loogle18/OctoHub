//
//  ProfileViewController.swift
//  OctoHub
//
//  Created by Медведь Святослав on 02.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit
import Octokit

class ProfileViewController: UIViewController {
    @IBOutlet weak var topProfileView: UIView!
    
    var config: TokenConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = self.navigationController!.navigationBar
        navigationBar.barTintColor = UIColor.customBlue
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBar.setValue(true, forKey: "hidesShadow")
        navigationBar.isTranslucent = false
        topProfileView.layer.backgroundColor = UIColor.customBlue.cgColor
    }
}
