//
//  TokenLoginViewController.swift
//  OctoHub
//
//  Created by Медведь Святослав on 16.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class TokenLoginViewController: ViewController {
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.layer.cornerRadius = 4
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.makeTransparentNavigationBar = true
        
        super.viewWillAppear(animated)
    }
}
