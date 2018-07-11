//
//  CreateUsernameViewController.swift
//  Makestagram
//
//  Created by Simone Chan on 7/11/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit

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
        
    }
    
}
