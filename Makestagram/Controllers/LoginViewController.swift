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
        UserService.show(forUID: user!.uid) { (user) in
            //If user exists, returns back to main storyboard
            if let user = user {
                //handle existing user
                User.setCurrent(user)
            
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
            else {
                self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
            }
        }
    }
}


