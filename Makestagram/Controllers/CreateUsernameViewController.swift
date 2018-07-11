//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Simone Chan on 7/11/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 6
    }

    //Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    //Actions
    @IBAction func nextButtonTapped(_ sender: Any) {
        //create new user and store in database
        
        //1) we guard to check that a FIRUser is logged in and a username is provided in text field
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
    
        //Method to handle networking between database
        UserService.create(firUser, username: username) { (user) in
            guard let user = user else { return }
            
            print("Created new user: \(user.username)")
        }
        
    }
    
}
