//
//  AppDelegate.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 07/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Initialize sign-in
        GIDSignIn.sharedInstance().clientID = GOOGLE_CLIENT_ID
        GIDSignIn.sharedInstance().delegate = self
        
        // Override point for customization after application launch.
        
        /// create the main Screen
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = kBackgroundColor
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
         // initialisation of Splash VC
        let controller = storyboard.instantiateViewController(withIdentifier: "SplashVC") as! SplashViewController
        
        window?.rootViewController  = controller
        window?.makeKeyAndVisible()
              
        return true
    }
    
    
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    
    func application(_ application: UIApplication,
                     open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
      if let error = error {
        if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
          print("The user has not signed in before or they have since signed out.")
        } else {
          print("\(error.localizedDescription)")
        }
        return
      }
        
      // Perform any operations on signed in user here.
      let userId = user.userID                  // For client-side use only!
      let idToken = user.authentication.idToken // Safe to send to the server
      let fullName = user.profile.name
      let givenName = user.profile.givenName
      let familyName = user.profile.familyName
      let email = user.profile.email
      // ...
    }
    
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
      // Perform any operations when the user disconnects from app here.
      // ...
    }


}

