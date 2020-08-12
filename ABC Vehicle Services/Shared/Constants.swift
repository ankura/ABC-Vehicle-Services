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
let kUserId             = "User_ID"
let kMD5Password        = "userPassword"

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


enum slideOutState: Int {
  case collapsed = 0,
  leftPanelExpanded
}

enum servicingStatus: Int {
    case no_active_servicing = 0,
    active_servicing
}

enum servicingItemStatus: Int {
    case not_started_servicing = 0,
    in_progress_servicing,
    completed_servicing
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
    case email_empty_str = "EMAIL_EMPTY_STR"
    case email_notvalid_str = "EMAIL_NOT_VALID_STR"
    case pass_empty_str = "PASS_EMPTY_STR"
    case pass_notvalid_str = "PASS_NOT_VALID_STR"
    case passcode_use_str = "PASSCODE_USE_STR"
    case passcode_req_str = "PASSCODE_REQ_STR"
    case something_wrong_str = "SOMETHING_WRONG_STR"
    case auth_success_str =  "AUTH_SUCCESS_STR"
    case logout_str = "LOGOUT_STR"
    case service_status_str = "SERVICE_STATUS_STR"
    case estimation_str = "ESTIMATION_STR"
    case no_service_prog_str = "NO_SERVICE_PROG_STR"
    case not_started_str = "NOT_STARTED_STR"
    case in_progress_str = "IN_PROGRESS_STR"
    case completed_str = "COMPLETED_STR"
    case google_sign_issue_str = "GOOGLE_SIGN_ISSUE_STR"
    case logout_conf_str = "LOGOUT_CONF_STR"
    case km_driven_str = "KM_DRIVEN_STR"
    case fuel_level_str = "FUEL-LEVEL_STR"
    case tyre_thread_str = "TYRE_THREAD_STR"
    case engine_health_str = "ENGINE_HEALTH_STR"
    case oil_level_str = "OIL_LEVEL_STR"
    case battery_life_str = "BATTERY_LIFE_STR"
    case oil_change_str = "OIL_CHANGE_STR"
    case brake_oil_str = "BRAKE_OIL_STR"
    case oil_filter_str = "OIL_FILTER_STR"
    case battery_check_str = "BATTERY_CHECK_STR"

    
    case alert_title_fail = "ALERT_TITLE_FAIL"
    case alert_title_error = "ALERT_TITLE_ERROR"
    case alert_ok = "ALERT_OK"
    case alert_title_success = "ALERT_TITLE_SUCCESS"
    case alert_title_confirmation = "ALERT_TITLE_CONFIRMATION"
    case alert_yes = "ALERT_YES"
    case alert_no = "ALERT_NO"
    
    
    case img_splash_main = "SPLASH_MAIN_IMG"
    case img_splash = "SPLASH_IMG"
    case img_google_login = "GICON_LOGIN_IMG"
    case img_service_status = "SERVICE_STATUS_IMG"
    case img_book_service = "BOOK_SERVICE_IMG"
    case img_menu = "MENU_IMG"
    case img_notification = "NOTIFICATION_IMG"
    case img_service_oil = "SERVICE_OIL_IMG"
    case img_service_break_oil = "SERVICE_BREAK_OIL_IMG"
    case img_service_filer = "SERVICE_FILTER_IMG"
    case img_service_battery = "SERVICE_BATTERY_IMG"
    
    
    
    var string: String {
        return rawValue.localized()
    }
}

struct carInfoItem {
    var title:String?
    var value:String?
}

struct ServiceStatusItem {
    var serviceItemTitle: String?
    var serviceItemImage: String?
    var serviceItemStatus: servicingItemStatus?
    var serviceItemTime:  String?
}

let kBackgroundColor = UIColor.init(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0) // white
let kBrandColor = UIColor.init(red: 75.0/255.0, green: 169.0/255.0, blue: 205.0/255.0, alpha: 1.0)
//let kBrandColor = UIColor.init(red: 118.0/255.0, green: 179.0/255.0, blue: 208.0/255.0, alpha: 1.0)


let TIMEOUT_API = 60.0

let API_URL = ""
let GOOGLE_CLIENT_ID = "681109074889-e54t29usie7ttuq654p4m1dt81t6vhbp.apps.googleusercontent.com"
