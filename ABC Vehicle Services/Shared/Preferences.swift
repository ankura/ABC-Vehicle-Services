//
//  Preferences.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 07/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  This is preferences class used to save the small data like user, other required info


import UIKit
import SwiftyJSON

/// This is preferences class used to save the small data
/// like user, other required info
/// All the methods are class methods
class Preferences: NSObject {
    
    /// Save Remember Me
    /// Method to store the remember me option in Standard defautls
    ///
    /// - Parameter answer: yes or no
    class func rememberMe(answer: String)
    {
        UserDefaults.standard.set(answer, forKey: kLoginIsRemember)
        UserDefaults.standard.synchronize()
    }
    
    
    /// Return Remember Me
    /// Method to store the remember me option in Standard defautls
    ///
    /// - Returns : String
    class func isRememberMe() -> String? {
        let value =  UserDefaults.standard.value(forKey: kLoginIsRemember)
        return value != nil ? value as! String : ""
    }
    
    
    /// Save Login
    /// Method to store the Login me option in Standard defautls
    ///
    /// - Parameter answer: yes or no
    class func LoginMe(answer: String)
    {
        UserDefaults.standard.set(answer, forKey: kUserLogin)
        UserDefaults.standard.synchronize()
    }
    
    
    /// Return isLogin
    /// Method to store the Login me option in Standard defautls
    ///
    /// - Returns : String
    class func isLoginMe() -> String? {
        let value =  UserDefaults.standard.value(forKey: kUserLogin)
        return value != nil ? value as! String : ""
    }
}
