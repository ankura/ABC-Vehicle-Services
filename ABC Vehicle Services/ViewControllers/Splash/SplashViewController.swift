//
//  SplashViewController.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 07/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Splash View Controller

import UIKit
import AVFoundation
import LocalAuthentication
import Darwin

class SplashViewController: UIViewController {
    
    @IBOutlet var splashMainImg: UIImageView!
    @IBOutlet var splashTextImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundColor
        
        splashMainImg.image = UIImage(named: LocalizationKey.img_splash_main.string)
        splashTextImg.image = UIImage(named: LocalizationKey.img_splash.string)
        
        drawUI()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        sleep(2)
        
        // Do any additional setup after loading the view.
        // if user is login and remember me is checked or if user uses Google's sign in
        if Preferences.isLoginMe() == "yes"
        {
            if(Preferences.isRememberMe() == "yes") {
                
                self.authenticationWithTouchID()
                
            } else {
                // navigate to login screen
                showLoginVC()
            }
            
        } else {
            // navigate to login screen
            showLoginVC()
        }
        
    }
    
    // Method to draw UI on screen based on device type and orientation
    func drawUI() {
        
        let guide = self.view.safeAreaLayoutGuide
        
        splashMainImg.translatesAutoresizingMaskIntoConstraints = false
        splashMainImg.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        splashMainImg.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.60).isActive = true
        splashMainImg.centerYAnchor.constraint(greaterThanOrEqualTo: guide.centerYAnchor, constant: -(splashMainImg.image?.size.height)!/4).isActive = true
        
        splashTextImg.translatesAutoresizingMaskIntoConstraints = false
        splashTextImg.topAnchor.constraint(equalTo: splashMainImg.bottomAnchor,constant: 0).isActive = true
        splashTextImg.centerXAnchor.constraint(equalTo: guide.centerXAnchor).isActive = true
        splashTextImg.heightAnchor.constraint(lessThanOrEqualTo: self.view.heightAnchor, multiplier: 0.20).isActive = true
        
        
    }
    
    
    // Method to show login VC
    func showLoginVC() {
        let loginVC =  self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")as! LoginViewController
        UIApplication.shared.windows.first?.rootViewController = loginVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    // Method to show Home VC
    func showHomeVC() {
        
        // custom navigation bar color
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationBarAppearace.barTintColor = kBrandColor
        
        // initialisation of navigation controller and home vc
        let navigationController = UINavigationController()
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC")as! HomeViewController
        navigationController.addChild(homeVC)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
    // Method to authenticate with biometric if 'remember me' is ON
    func authenticationWithTouchID() {
        let localAuthenticationContext = LAContext()
        localAuthenticationContext.localizedFallbackTitle = LocalizationKey.passcode_use_str.string
        
        var authorizationError: NSError?
        let reason = LocalizationKey.passcode_req_str.string
        
        if localAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authorizationError) {
            
            localAuthenticationContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, evaluateError in
                
                if success {
                    DispatchQueue.main.async() {
                        
                        self.showHomeVC()
                        /*self.showAlert(title: LocalizationKey.alert_title_success.string, message: LocalizationKey.auth_success_str.string, actionTitle: LocalizationKey.alert_ok.string, completion: { (success) -> Void in
                        if success {
                            
                        }})*/
                    }
                    
                } else {
                    // Failed to authenticate
                    guard let error = evaluateError else {
                        return
                    }
                    Common.LogDebug("\(error.localizedDescription)")
                    DispatchQueue.main.async() {
                    self.showAlert(title: LocalizationKey.alert_title_error.string, message: error.localizedDescription, actionTitle: LocalizationKey.alert_ok.string, completion: { (success) -> Void in
                        if success {
                            exit(0)
                        }})
                    }
                }
            }
        } else {
            
            guard let error = authorizationError else {
                return
            }
            Common.LogDebug("\(error.localizedDescription)")
            
            DispatchQueue.main.async() {
            self.showAlert(title: LocalizationKey.alert_title_error.string, message: error.localizedDescription, actionTitle: LocalizationKey.alert_ok.string, completion: { (success) -> Void in
                if success {
                    self.showHomeVC()
                }})
            }
            
        }
    }

}
