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
    
    
    /// Save User ID
    /// Method to store the User ID option in Standard defautls
    ///
    /// - Parameter answer: yes or no
    class func userID(value: String)
    {
        UserDefaults.standard.set(value, forKey: kUserId)
        UserDefaults.standard.synchronize()
    }
    
    
    /// Return User ID
    /// Method to return the User ID option
    ///
    /// - Returns : String
    class func userIdValue() -> String? {
        let value =  UserDefaults.standard.value(forKey: kUserId)
        return value != nil ? value as! String : ""
    }
    
    
    /// Save MD5 Password
    /// Method to store the MD5 Password option in Standard defautls
    ///
    /// - Parameter value: yes or no
    class func MD5Password(value: String)
    {
        UserDefaults.standard.set(value, forKey: kMD5Password)
        UserDefaults.standard.synchronize()
    }
    
    
    /// Return MD5Password
    /// Method to return the MD5Password option
    ///
    /// - Returns : String
    class func MD5PasswordValue() -> String? {
        let value =  UserDefaults.standard.value(forKey: kMD5Password)
        return value != nil ? value as! String : ""
    }
}
