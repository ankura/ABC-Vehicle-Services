//
//  Common.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 07/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
/// Common class is used to common operations performed across the app


import Foundation
import UIKit
import os
import SwiftyJSON
import CommonCrypto

class Common: NSObject {
    
    /// method to log "Info" type of string. Use this level to capture information that may be helpful, but isn’t essential
    /// - Parameters:
    ///   - log: A constant string or format string that produces a human-readable log message.
    ///   - logCateg: category of subsystem.
    ///   - logLev: Denote the privacy level of the log
    class func LogInfo(_ log: String?, _ logCateg: logCategory = .ui, _ logLev: logLevel = .publicLevel) {
        
        guard let  logDetails = log, !logDetails.isEmpty else {
            print("String is nil or empty.")
            return
        }
        
        switch(logLev)  {
        case .publicLevel:
            switch(logCateg) {
            case .ui:
                os_log("ABC Services - %{public}@", log: .ui, type: .info, logDetails)
            case .database:
                os_log("ABC Services - %{public}@", log: .database, type: .info, logDetails)
            case .network:
                os_log("ABC Services - %{public}@", log: .network, type: .info, logDetails)
            }
        case .privateLevel:
            switch(logCateg) {
            case .ui:
                os_log("ABC Services - %{private}@", log: .ui, type: .info, logDetails)
            case .database:
                os_log("ABC Services - %{private}@", log: .database, type: .info, logDetails)
            case .network:
                os_log("ABC Services - %{private}@", log: .network, type: .info, logDetails)
            }
        }
        
    }
    
    
    /// method to log "Error" type of string. Use this log level to report process-level errors
    /// - Parameters:
    ///   - log: A constant string or format string that produces a human-readable log message.
    ///   - logCateg: category of subsystem.
    ///   - logLev: Denote the privacy level of the log
    class func LogError(_ log: String?, _ logCateg: logCategory = .ui, _ logLev: logLevel = .publicLevel) {
        
        guard let  logDetails = log, !logDetails.isEmpty else {
            print("String is nil or empty.")
            return
        }
        
        switch(logLev)  {
        case .publicLevel:
            switch(logCateg) {
            case .ui:
                os_log("ABC Services - %{public}@", log: .ui, type: .error, logDetails)
            case .database:
                os_log("ABC Services - %{public}@", log: .database, type: .error, logDetails)
            case .network:
                os_log("ABC Services - %{public}@", log: .network, type: .error, logDetails)
            }
        case .privateLevel:
            switch(logCateg) {
            case .ui:
                os_log("ABC Services - %{private}@", log: .ui, type: .error, logDetails)
            case .database:
                os_log("ABC Services - %{private}@", log: .database, type: .error, logDetails)
            case .network:
                os_log("ABC Services - %{private}@", log: .network, type: .error, logDetails)
            }
        }
    }
    
    
    /// method to log "Debug" type of string. Use this level to capture information that may be useful during development
    /// - Parameters:
    ///   - log: A constant string or format string that produces a human-readable log message.
    ///   - logCateg: category of subsystem.
    ///   - logLev: Denote the privacy level of the log
    class func LogDebug(_ log: String?, _ logCateg: logCategory = .ui, _ logLev: logLevel = .publicLevel) {
        
        guard let  logDetails = log, !logDetails.isEmpty else {
            print("String is nil or empty.")
            return
        }
        
        switch(logLev)  {
        case .publicLevel:
            switch(logCateg) {
            case .ui:
                os_log("ABC Services - %{public}@", log: .ui, type: .debug, logDetails)
            case .database:
                os_log("ABC Services - %{public}@", log: .database, type: .debug, logDetails)
            case .network:
                os_log("ABC Services - %{public}@", log: .network, type: .debug, logDetails)
            }
        case .privateLevel:
            switch(logCateg) {
            case .ui:
                os_log("ABC Services - %{private}@", log: .ui, type: .debug, logDetails)
            case .database:
                os_log("ABC Services - %{private}@", log: .database, type: .debug, logDetails)
            case .network:
                os_log("ABC Services - %{private}@", log: .network, type: .debug, logDetails)
            }
        }
    }
    
    
    /// method to generate random string
    /// - Parameter length: length of random string
    /// - Returns: random string in String format
    class func generateRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let timeStamp = String(format:"%.0f",NSDate().timeIntervalSince1970 * 1000)
        let randomStr = String((0..<length-timeStamp.count).map{ _ in letters.randomElement()! })
        return randomStr + timeStamp
    }
    
    
    /// class method to validate the empty object
    /// - Parameter object: Object
    /// - Returns: true/false, returns true if empty
    class func isEmptyObject(object:AnyObject) -> Bool {
        
        return object.isEmpty
    }
    
    
    /// class method to get the jsonstring  object from json
    /// - Parameter object: object
    /// - Returns: json in format of string
    class  func jsonString(fromObject object: Any) -> String {
        
        let jsonData: Data? = try? JSONSerialization.data(withJSONObject: object, options: [])
        var jsonString: String? = nil
        if jsonData == nil {
        }
        else {
            jsonString = String(bytes: jsonData!, encoding: String.Encoding.utf8)
        }
        return jsonString!
    }
    
    
    /// class method to get the json object from string
    /// - Parameter string: string
    /// - Returns: json object
    class func jsonObject(from string: String) -> Any {
        let error: Error? = nil
        let data: Data? = string.data(using: String.Encoding.utf8)
        let object: Any? = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
        if error != nil || object == nil {
            
            return ["message": LocalizationKey.timeout_str.string]
        }
        else {
            
            return object!
        }
    }
    
    
    /// Convert params array into json string
    /// - Parameter paramsArray: array
    /// - Returns: json string
    class func getJsonString(_ paramsArray : [String:String]) ->String  {
        var jsonData : Data!
        var str : String!
        do{jsonData = try JSONSerialization.data(withJSONObject: paramsArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                str = JSONString
            }}catch {Common.LogDebug("error")}
        return str
    }
    
    
    /// Convert params array into json string
    /// - Parameter paramsArray: array
    /// - Returns: json string
    class func getJsonString(_ paramsArray : [String:Any]) ->String  {
        var jsonData : Data!
        var str : String!
        do{jsonData = try JSONSerialization.data(withJSONObject: paramsArray, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                str = JSONString
            }}catch {Common.LogDebug("error")}
        return str
    }
    
    /// Convert params json string into  string
    /// - Parameter describing: JSON string
    /// - Returns:  string
    class func getJsonString(describing: JSON?) ->String {
        var str : String = ""
        str = String(describing: describing)
        return str
    }
    
    /// Method to get font size depending upon screen width
    /// - Parameter size: input font size
    /// - Returns:  CGFloat: font as per screen dimension.
    class func dynamicFontSize(_ size: CGFloat) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.size.width
        var calculatedFontSize = (screenWidth / 600) * size
        if(calculatedFontSize < size) {
            calculatedFontSize = size
        }
        return calculatedFontSize
    }
    
    /// Method to return device family
    /// - Returns:  Bool: True if iPhone family else False
    class func isPhone() -> Bool {
        if(UIDevice.current.userInterfaceIdiom == .phone) {
            return true
        } else {
            return false
        }
    }
    
    /// Method to return device orientation
    /// - Returns:  Bool: True if potrait else False
    class func isPotrait() -> Bool {
        
        let orient = UIApplication.shared.statusBarOrientation
        switch orient {
        case .portrait, .portraitUpsideDown :
            return true
        case .landscapeLeft,.landscapeRight :
            return false
        default:
            return false
        }
    }
    
    
    /// Method to encrypt
    /// - Parameter string: plain string
    /// - Returns:  string: encrypted  string
    class func md5(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
    
    /// Method to reset values in case of logout
    class func logOutResetValue() {
        Preferences.LoginMe(answer: "no")
        Preferences.rememberMe(answer: "no")
        Preferences.userID(value: "")
        Preferences.MD5Password(value: "")
    }
    
}


//  OSLog extension
extension OSLog {
    // bundle indentifier as subsystem
    private static var subsystem = Bundle.main.bundleIdentifier!
    
    // different categories for subsystem.
    static let ui = OSLog(subsystem: subsystem, category: "UI")
    static let network = OSLog(subsystem: subsystem, category: "Network")
    static let database = OSLog(subsystem: subsystem, category: "Database")
}

// Extension for showing alert
extension UIViewController {
    
    
    /// Show alert
    /// - Parameters:
    ///   - title: title to be shown on alert
    ///   - message: message to be shown on alert
    ///   - actionTitle: action title
    func showAlert(title: String, message: String, actionTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 18.0)!]
        let messageFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 14.0)!]
        
        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: { _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// Show alert
    /// - Parameters:
    ///   - title: title to be shown on alert
    ///   - message: message to be shown on alert
    ///   - actionTitle: action title
    ///   - completion: completion handler
    /// - Returns: returns true on completion 
    func showAlert(title: String, message: String, actionTitle: String, completion: @escaping (Bool) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 18.0)!]
        let messageFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 14.0)!]
        
        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: { _ in
            completion(true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// Show alert
    /// - Parameters:
    ///   - title: title to be shown on alert
    ///   - message: message to be shown on alert
    ///   - actionTitle: action title
    ///    - secondTitle: second title
    ///   - completion: completion handler
    /// - Returns: returns true on completion
    func showAlert(title: String, message: String, actionTitle: String, secondTitle: String, completion: @escaping (Bool,Int) -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "ArialHebrew-Bold", size: 18.0)!]
        let messageFont = [NSAttributedString.Key.font: UIFont(name: "Avenir-Roman", size: 14.0)!]
        
        let titleAttrString = NSMutableAttributedString(string: title, attributes: titleFont)
        let messageAttrString = NSMutableAttributedString(string: message, attributes: messageFont)
        alert.setValue(titleAttrString, forKey: "attributedTitle")
        alert.setValue(messageAttrString, forKey: "attributedMessage")
        
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: { _ in
            completion(true,0)
        }))
        
        alert.addAction(UIAlertAction(title: secondTitle, style: UIAlertAction.Style.default, handler: { _ in
            completion(true,1)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// extension of String
extension String {
    
    // Function for localisation
    func localized() -> String {
      let localizedString = NSLocalizedString(self, comment: "")
      return localizedString
    }
    
    // Function to validate is string is valid email id or not
    func isValidEmail() -> Bool {
            NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}

// extension of Mutable String
extension NSMutableAttributedString {

    // Function to set color to input attributed string
    /// - Parameters:
    ///   - textForAttribute: Atributed string
    ///   - color: color to set for input string
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
    // Function to set font to input attributed string
    /// - Parameters:
    ///   - textForAttribute: Atributed string
    ///   - font: font to set for input string
    func setFontForText(textForAttribute: String, withFont font: UIFont) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.font, value: font, range: range)
    }

}

// extension of UITextField
extension UITextField {
    
    // Function to set border at bottom of textfield
    func addBottomBorder(){
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        bottomLine.name = "bottomLine"
        borderStyle = .none
        for lay in layer.sublayers ?? [] where lay.name == "bottomLine" {
                 lay.removeFromSuperlayer()
        }
        layer.addSublayer(bottomLine)
    }
    
}
