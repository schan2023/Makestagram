//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Simone Chan on 7/9/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Outlets
    @IBOutlet weak var loginButton: UIButton!
    
    //Actions
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("login button was tapped")
    }
    
}
