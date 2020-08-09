//
//  Constants.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 07/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.

import Foundation
import UIKit
/// File to store constants which are used across the app

// constants for User Defaults
let kLoginIsRemember    = "isRemember"
let kUserLogin          = "isLogin"


// enums for log category
enum logCategory: Int
{
    case ui = 0,
    network,
    database
}

// enums for log level privacy
enum logLevel: Int
{
    case publicLevel = 0,
    privateLevel
}


// enums for localisation
enum LocalizationKey: String {
    // enum value = Key of string
    case timeout_str = "TIMEOUT_STR"
    case welcome_str = "WELCOME_STR"
    case login_str = "LOGIN_STR"
    case emailid_str = "EMAILID_STR"
    case email_place_str = "EMAIL_PLACE_STR"
    case pass_str = "PASS_STR"
    case pass_place_str = "PASS_PLACE_STR"
    case remember_me_str = "REMEMBER_ME_STR"
    case forgot_pass_str = "FORGOT_PASS_STR"
    case or_str = "OR_STR"
    
    
    
    case alert_title_fail = "ALERT_TITLE_FAIL"
    
    case alert_ok = "ALERT_OK"
    
    
    
    case img_splash_main = "SPLASH_MAIN_IMG"
    case img_splash = "SPLASH_IMG"
    case img_google_login = "GICON_LOGIN_IMG"
    
    
    
    var string: String {
        return rawValue.localized()
    }
}


let kImageColor = UIColor.init(red: 16.0/255.0, green: 191.0/255.0, blue: 212.0/255.0, alpha: 1.0)
let kTextColor = UIColor.init(red: 255.0/255.0, green: 179.0/255.0, blue: 57.0/255.0, alpha: 1.0)
let kOtherColor = UIColor.init(red: 238.0/255.0, green: 58.0/255.0, blue: 125.0/255.0, alpha: 1.0)
let kLightGreenColor = UIColor.init(red: 83.0/255.0, green: 138.0/255.0, blue: 5.0/255.0, alpha: 1.0)

let kBackgroundColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0) // white
let kBrandColor = UIColor.init(red: 75.0/255.0, green: 169.0/255.0, blue: 205.0/255.0, alpha: 1.0)
//let kBrandColor = UIColor.init(red: 118.0/255.0, green: 179.0/255.0, blue: 208.0/255.0, alpha: 1.0)


let TIMEOUT_API = 60.0

let API_URL = "https://raw.githubusercontent.com/AxxessTech/Mobile-Projects/master/challenge.json"
let GOOGLE_CLIENT_ID = "681109074889-e54t29usie7ttuq654p4m1dt81t6vhbp.apps.googleusercontent.com"
