//
//  User.swift
//  Makestagram
//
//  Created by Simone Chan on 7/10/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import FirebaseDatabase.FIRDataSnapshot

class User {
    
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
    static func setCurrent(_ user: User) {
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
