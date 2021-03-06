//
//  UserService.swift
//  Makestagram
//
//  Created by Simone Chan on 7/11/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase
/* func setValue(completion: ()->()) {

    do stuff
    completion(error, ref)
 
 */
struct UserService {
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
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
                completion(user)
            })
        }
    }
    
    //If FIRUser exists, we get a reference to the root of our JSON dictionary
    //We create a Database reference by adding a relative path /users/#{user.uid}
    //Created a relative path from location we want to read from
    //Read from path we created and pass an event closure to handle the data (snapshot) that is passed back from the database
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    
}
