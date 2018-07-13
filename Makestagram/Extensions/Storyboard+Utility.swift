//
//  Storyboard+Utility.swift
//  Makestagram
//
//  Created by Simone Chan on 7/12/18.
//  Copyright © 2018 Simone Chan. All rights reserved.
//

import Foundation
import UIKit

//way to access different storyboards
extension UIStoryboard {
    enum MGType: String {
        case main
        case login
        
        var filename: String {
            //capitalizes first letter in each case in enum for filenames
            return rawValue.capitalized
        }
    }
    
    convenience init(type: MGType, bundle: Bundle? = nil) {
        self.init(name: type.filename, bundle: bundle)
    }
    
    //Decides which storyboard should be initial view controller
    static func initialViewController(for type: MGType) -> UIViewController {
        let storyboard = UIStoryboard(type: type)
        guard let initialViewController = storyboard.instantiateInitialViewController() else {
            fatalError("Couldn't instantiate initial view controller for \(type.filename) storyboard.")
        }
        
        return initialViewController
    }
}
