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
        
        //2) create dictionary to store username
        let userAttrs = ["username": username]
        
        //3) specify relative path for where we want to store our data
        let ref = Database.database().reference().child("users").child(firUser.uid)
        
        //4) Write data we want to store
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return
            }
            //Read user we just wrote to database and create new user from snapshot
            ref.observeSingleEvent(of: .value, with: {(snapshot) in
                let user = User(snapshot: snapshot)
            })
        }
    }
    
}
