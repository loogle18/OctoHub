//
//  ViewController.swift
//  OctoHub
//
//  Created by Медведь Святослав on 14.08.17.
//  Copyright © 2017 loogle18. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String = "Oops", message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
