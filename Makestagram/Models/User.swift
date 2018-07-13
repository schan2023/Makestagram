//
//  User.swift
//  Makestagram
//
//  Created by Simone Chan on 7/10/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User: Codable {
    
    //Singleton
    //holds current user
    private static var _current: User?
    
    //getter to access private variable
    static var current: User {
        //check current is of type user, throws error if nil
        guard let currentUser = _current else {
            fatalError("Error: current user does not exist")
        }
        return currentUser
    }
    
    //Creates custom setter method to set current user
    //Takes in parameter bool to determine if user should be written to UserDefaults
    static func setCurrent(_ user: User, writeToUserDefaults: Bool = false) {
        //Check if bool is true, if true, we write to user defaults
        if writeToUserDefaults {
            //Use JSONEncoder to turn our user object into Data
            if let data = try? JSONEncoder().encode(user) {
                //Store data with correct key in UserDefaults
                UserDefaults.standard.set(data, forKey: Constants.UserDefaults.currentUser)
            }
        }
        _current = user
    }
    
    //Properties
    let uid: String
    let username: String
    
    //Init
    init(uid: String, username: String) {
        self.uid = uid
        self.username = username
    }
    
    //Failable initializer - creates reusable initializer that we can use to create user objects from snapshots
    init?(snapshot: DataSnapshot) {
        //Casts snapshots to dictionary types and checks if it contains a username key/value
        //Fails and returns nil if not found
        guard let dict = snapshot.value as? [String: Any],
            let username = dict["username"] as? String
            else { return nil }
        
        //Stores key property of snapshot -> UID
        self.uid = snapshot.key
        self.username = username
    }
    
    
}
