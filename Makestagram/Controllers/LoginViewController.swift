//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Simone Chan on 7/9/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

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
        //Access FUIAuth default auth UI singleton
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        //Set FUIAuth's singleton's delegate
        authUI.delegate = self
        //Present the auth view controller
        let authViewController = authUI.authViewController()
        //Implement FUIAuthDelegate protocol
        present(authViewController, animated: true)
    }
    
}

//Conforms LoginViewController to FUIAuthDelegate
extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)" )
            return
        }

        //Building database reference
        //If FIRUser exists, we get a reference to the root of our JSON dictionary
        //We create a Database reference by adding a relative path /users/#{user.uid}
        //Created a relative path from location we want to read from
        guard let user = user
            else { return }
        let userRef = Database.database().reference().child("users").child(user.uid)

        //Read from path we created and pass an event closure to handle the data (snapshot) that is passed back from the database
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            //Retrieving snapshot of data - if snapshot exists, user exists
            if let user = User(snapshot: snapshot) {
                print("Welcome back, \(user.username).")
            }
            else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            }
        })
    }
}


