//
//  LoginViewController.swift
//  ABC Vehicle Services
//
//  Created by Ankur Agarwal on 07/08/20.
//  Copyright © 2020 Ankur Agarwal. All rights reserved.
//  Login View Controller

import Foundation
import UIKit
import SwiftyJSON
import Toast_Swift
import Alamofire
import GoogleSignIn

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = kBackgroundColor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let blueBackView: UIView = {
        let view = UIView()
        view.backgroundColor = kBrandColor
        //view.layer.cornerRadius = 90
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let engineerImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: LocalizationKey.img_splash_main.string)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 100
        return imgView
    }()
    
    private let whiteBKView: UIView = {
        // white box
        let view = UIView()
        view.backgroundColor = kBackgroundColor
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
       // welcome text
        let title = UILabel()
        title.text = LocalizationKey.welcome_str.string
        title.font = UIFont.systemFont(ofSize: Common.dynamicFontSize(18), weight: UIFont.Weight.semibold)
        title.textColor = .white
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    
    private let loginLabel: UILabel = {
        //Login Label
        let login = UILabel()
        login.text = LocalizationKey.login_str.string
        login.font = UIFont.systemFont(ofSize: Common.dynamicFontSize(20), weight: UIFont.Weight.semibold)
        login.textColor = .black
        login.textAlignment = .left
        
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    private let lineView: UIView = {
        // brand line
        let view = UIView()
        view.backgroundColor = kBrandColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let emailIDLabel: UILabel = {
        //Email ID Label
        let label = UILabel()
        label.text = LocalizationKey.emailid_str.string
        label.font = UIFont.systemFont(ofSize: Common.dynamicFontSize(15), weight: UIFont.Weight.medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
       // email textfield
        let textField =  UITextField()
        textField.placeholder = LocalizationKey.email_place_str.string
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.textContentType = .emailAddress
        textField.autocapitalizationType = .none
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        //Password Label
        let label = UILabel()
        label.text = LocalizationKey.pass_str.string
        label.font = UIFont.systemFont(ofSize: Common.dynamicFontSize(15), weight: UIFont.Weight.medium)
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let passwordTextField: UITextField = {
       // Password textfield
        let textField =  UITextField()
        textField.placeholder = LocalizationKey.pass_place_str.string
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.keyboardType = .default
        textField.returnKeyType = .done
        textField.clearButtonMode = .whileEditing
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let rememberMeCheckBox: CheckBox = {
       // Remember Me Checkbox
        let checkBox = CheckBox()
        checkBox.style = .tick
        checkBox.borderStyle = .square
        checkBox.uncheckedBorderColor = .black
        checkBox.checkedBorderColor = .black
        checkBox.checkmarkColor = .black
        checkBox.addTarget(self, action: #selector(rememberMe), for: .valueChanged)
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()
    
    private let rememberMeLabel : UILabel = {
        // Remember Me label
        let label = UILabel()
        label.text = LocalizationKey.remember_me_str.string
        label.font = UIFont.systemFont(ofSize: Common.dynamicFontSize(15), weight: UIFont.Weight.medium)
        label.textColor = .black
        label.textAlignment = .left
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let forgotPasswordLabel : UILabel = {
        // Forgot Password label
        let label = UILabel()
        label.text = LocalizationKey.forgot_pass_str.string
        label.font = UIFont.systemFont(ofSize: Common.dynamicFontSize(15), weight: UIFont.Weight.medium)
        label.textColor = .black
        label.textAlignment = .right
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let loginButton : UIButton = {
        // Login Button
         let button = UIButton()
        button.addTarget(self, action: #selector(loginTapped), for: UIControl.Event.touchUpInside)
        button.layer.cornerRadius = 3
        button.backgroundColor = kBrandColor
        button.setTitle(LocalizationKey.login_str.string, for: UIControl.State.normal)
        button.titleLabel?.textColor = .white
        button.titleLabel?.font = UIFont.systemFont(ofSize: Common.dynamicFontSize(18), weight: UIFont.Weight.bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let orView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let orLabel = UILabel()
        orLabel.text = LocalizationKey.or_str.string
        orLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.semibold)
        orLabel.textColor = .gray
        orLabel.textAlignment = .center
        orLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(orLabel)
        
        //orLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        orLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        //orLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        let leftLineview = UIView()
        leftLineview.backgroundColor = .gray
        leftLineview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(leftLineview)
        
        leftLineview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        leftLineview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        leftLineview.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -5).isActive = true
        leftLineview.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        let rightLineview = UIView()
        rightLineview.backgroundColor = .gray
        rightLineview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightLineview)
        
        rightLineview.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        rightLineview.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 5).isActive = true
        rightLineview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        rightLineview.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        return view
        
    }()
    
    
    private let googleLoginButton : UIButton = {
        // Google Button
        let gButton = UIButton()
        gButton.layer.cornerRadius = 3
        gButton.setBackgroundImage(UIImage(named: LocalizationKey.img_google_login.string), for: .normal)
        gButton.addTarget(self, action: #selector(googleLoginTapped), for: UIControl.Event.touchUpInside)
        gButton.translatesAutoresizingMaskIntoConstraints = false
        return gButton
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kBackgroundColor
        
        addUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(rememberMeTapped(_:)))
        tap.numberOfTapsRequired = 1
        tap.numberOfTouchesRequired = 1
        self.rememberMeLabel.addGestureRecognizer(tap)
        
        let tapPass = UITapGestureRecognizer(target: self, action: #selector(forgotPassTapped(_:)))
        tapPass.numberOfTapsRequired = 1
        tapPass.numberOfTouchesRequired = 1
        self.forgotPasswordLabel.addGestureRecognizer(tapPass)
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.receiveToggleAuthUINotification(_:)), name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
            drawUI()
    }
    
    func addUI() {
        
        self.view.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.blueBackView)
        
        self.scrollView.addSubview(self.engineerImageView)
        
        self.scrollView.addSubview(self.whiteBKView)
        
        self.scrollView.addSubview(self.titleLabel)
        
        self.scrollView.addSubview(self.loginLabel)
        
        self.scrollView.addSubview(self.lineView)
        
        self.scrollView.addSubview(self.emailIDLabel)
        
        self.emailTextField.delegate = self
        self.scrollView.addSubview(self.emailTextField)
        
        self.scrollView.addSubview(self.passwordLabel)
        
        self.passwordTextField.delegate = self
        self.scrollView.addSubview(self.passwordTextField)
        
        self.scrollView.addSubview(self.rememberMeCheckBox)
        
        self.scrollView.addSubview(self.rememberMeLabel)
        
        self.scrollView.addSubview(self.forgotPasswordLabel)
        
        self.scrollView.addSubview(self.loginButton)
        
        self.scrollView.addSubview(self.orView)
        
        self.scrollView.addSubview(self.googleLoginButton)
    }
    
    func drawUI() {
            
        //setup scroll view
        
        self.scrollView.frame = self.view.frame
        
        self.scrollView.removeConstraints(self.scrollView.constraints)
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  0).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        var val: CGFloat = 0.0
        var mul: CGFloat = 0.0
        
        if(Common.isPhone() && !Common.isPotrait()) {
            val = 0.10
        }
        
        //Constraint
        self.blueBackView.removeConstraints(self.blueBackView.constraints)
        self.blueBackView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 0).isActive = true
        self.blueBackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 0).isActive = true
        self.blueBackView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant:  0).isActive = true
        self.blueBackView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: (0.33+val)).isActive = true
        
        //Constraint
        self.engineerImageView.removeConstraints(self.engineerImageView.constraints)
        engineerImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 10).isActive = true
        engineerImageView.widthAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 0.15).isActive = true
        engineerImageView.heightAnchor.constraint(equalTo: self.scrollView.heightAnchor, multiplier: 0.15).isActive = true
        engineerImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        
        if(!Common.isPhone()) {
            val = 60
        }
        
        self.whiteBKView.removeConstraints(self.whiteBKView.constraints)
        whiteBKView.topAnchor.constraint(equalTo: blueBackView.bottomAnchor, constant: (-45-val)).isActive = true
        whiteBKView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor).isActive = true
        whiteBKView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, multiplier: 0.90).isActive = true
        whiteBKView.heightAnchor.constraint(equalToConstant: 60+val).isActive = true
        
        self.titleLabel.removeConstraints(self.titleLabel.constraints)
        titleLabel.topAnchor.constraint(equalTo: self.whiteBKView.topAnchor, constant: (-55-val/2)).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        self.loginLabel.removeConstraints(self.loginLabel.constraints)
        loginLabel.topAnchor.constraint(equalTo: self.whiteBKView.topAnchor, constant: 25+val).isActive = true
        loginLabel.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: 20).isActive = true
        loginLabel.widthAnchor.constraint(equalTo: self.whiteBKView.widthAnchor).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 45).isActive = true
    
        
        self.lineView.removeConstraints(self.lineView.constraints)
        lineView.topAnchor.constraint(equalTo: self.loginLabel.bottomAnchor, constant: 10).isActive = true
        lineView.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: 20).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        
        mul = 1.0
        if(!Common.isPhone()) {
            mul = 2.0
        }
        
        
        self.emailIDLabel.removeConstraints(self.emailIDLabel.constraints)
        emailIDLabel.topAnchor.constraint(equalTo: self.lineView.bottomAnchor, constant: 15*mul).isActive = true
        emailIDLabel.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: 20).isActive = true
        emailIDLabel.widthAnchor.constraint(equalTo: self.whiteBKView.widthAnchor).isActive = true
        emailIDLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        emailTextField.frame.size = CGSize(width: self.scrollView.frame.size.width*0.90-40, height: 30)
        self.emailTextField.removeConstraints(self.emailTextField.constraints)
        emailTextField.topAnchor.constraint(equalTo: self.emailIDLabel.bottomAnchor, constant: 5*mul).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.whiteBKView.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        emailTextField.addBottomBorder()
        
        
        self.passwordLabel.removeConstraints(self.passwordLabel.constraints)
        passwordLabel.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 15*mul).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: 20).isActive = true
        passwordLabel.widthAnchor.constraint(equalTo: self.whiteBKView.widthAnchor).isActive = true
        passwordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        passwordTextField.frame.size = CGSize(width: self.scrollView.frame.size.width*0.90-40, height: 30)
        self.passwordTextField.removeConstraints(self.passwordTextField.constraints)
        passwordTextField.topAnchor.constraint(equalTo: self.passwordLabel.bottomAnchor, constant: 5*mul).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: self.whiteBKView.trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordTextField.addBottomBorder()
        
        
        self.rememberMeCheckBox.removeConstraints(self.rememberMeCheckBox.constraints)
        rememberMeCheckBox.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 15*mul).isActive = true
        rememberMeCheckBox.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: 20).isActive = true
        rememberMeCheckBox.widthAnchor.constraint(equalToConstant: 20*mul).isActive = true
        rememberMeCheckBox.heightAnchor.constraint(equalToConstant: 20*mul).isActive = true
        
        if(!Common.isPhone()) {
            val = 10
        }
        
        self.rememberMeLabel.removeConstraints(self.rememberMeLabel.constraints)
        rememberMeLabel.topAnchor.constraint(equalTo: self.rememberMeCheckBox.topAnchor, constant: -(20)/3+val).isActive = true
        rememberMeLabel.leadingAnchor.constraint(equalTo: self.rememberMeCheckBox.trailingAnchor, constant: 10).isActive = true
        rememberMeLabel.widthAnchor.constraint(equalTo: self.whiteBKView.widthAnchor, multiplier: 0.35).isActive = true
        rememberMeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.forgotPasswordLabel.removeConstraints(self.forgotPasswordLabel.constraints)
        forgotPasswordLabel.topAnchor.constraint(equalTo: self.rememberMeCheckBox.topAnchor, constant: -(20)/3+val).isActive = true
        forgotPasswordLabel.trailingAnchor.constraint(equalTo: self.whiteBKView.trailingAnchor, constant: -10).isActive = true
        forgotPasswordLabel.widthAnchor.constraint(equalTo: self.whiteBKView.widthAnchor, multiplier: 0.40).isActive = true
        forgotPasswordLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        var loginButtonHt: CGFloat = 0.00
        if(!Common.isPhone() && Common.isPotrait()) {
            val = 150.0
            loginButtonHt = 20.0
        } else if(!Common.isPotrait()) {
            if(!Common.isPhone()) {
                val = 300.0
                loginButtonHt = 20.0
            } else {
                val = 130.0
            }
        }
        
        self.loginButton.removeConstraints(self.loginButton.constraints)
        loginButton.topAnchor.constraint(equalTo: self.forgotPasswordLabel.bottomAnchor, constant: 15*mul*mul).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: (60+val)).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: self.whiteBKView.trailingAnchor, constant: (-60-val)).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 40+loginButtonHt).isActive = true
        
        
        self.orView.removeConstraints(self.loginButton.constraints)
        orView.topAnchor.constraint(equalTo: self.loginButton.bottomAnchor, constant: 40*mul).isActive = true
        orView.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: 0).isActive = true
        orView.widthAnchor.constraint(equalTo: self.whiteBKView.widthAnchor).isActive = true
        orView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        self.googleLoginButton.removeConstraints(self.googleLoginButton.constraints)
        googleLoginButton.topAnchor.constraint(equalTo: self.orView.bottomAnchor, constant: 15*mul*mul).isActive = true
        googleLoginButton.leadingAnchor.constraint(equalTo: self.whiteBKView.leadingAnchor, constant: (60+val)).isActive = true
        googleLoginButton.trailingAnchor.constraint(equalTo: self.whiteBKView.trailingAnchor, constant: (-60-val)).isActive = true
        googleLoginButton.heightAnchor.constraint(equalToConstant: 40+loginButtonHt).isActive = true

        
        
        
        
        print(self.view.frame)
        print(scrollView.contentSize)
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        
        val = 0.0
        if(Common.isPhone() && !Common.isPotrait()) {
            val = 50.0
        }
        print(contentRect.size)
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: (contentRect.size.height+val))
        print(scrollView.contentSize)
    }
    
    
   override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in

        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
                //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
                self.drawUI()
        })
        super.viewWillTransition(to: size, with: coordinator)

    }
    
    
    //MARK: - Protocol  - UITextFieldDelegate functions

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    
    //MARK: -
    
    
    @objc func rememberMe() {
        Common.LogDebug("Remeber Me Tappped")
    }
    
    @objc func rememberMeTapped(_ sender: UITapGestureRecognizer) {
        Common.LogDebug("Remeber Me Label Tappped")
        self.rememberMeCheckBox.isChecked = !self.rememberMeCheckBox.isChecked
    }
    
    
    @objc func forgotPassTapped(_ sender: UITapGestureRecognizer) {
        Common.LogDebug("Forgot Password Tappped")
    }
    
    
    @objc func loginTapped() {
        Common.LogDebug("Loggin Tappped")
        
        var msg: String = ""
        if(!self.emailTextField.hasText) {
            msg = LocalizationKey.email_empty_str.string
        } else if(!self.emailTextField.text!.isValidEmail()) {
            msg = LocalizationKey.email_notvalid_str.string
        } else if(!self.passwordTextField.hasText) {
            msg = LocalizationKey.pass_empty_str.string
        } else if(self.passwordTextField.text!.count < 8) {
            msg = LocalizationKey.pass_notvalid_str.string
        }
        
        if(msg.isEmpty) {
            if(self.rememberMeCheckBox.isChecked) {
                Preferences.rememberMe(answer: "yes")
            } else {
                Preferences.rememberMe(answer: "no")
            }
            Preferences.LoginMe(answer: "yes")
            Preferences.userID(value:self.emailTextField.text!)
            Preferences.MD5Password(value: Common.md5(self.passwordTextField.text!))
            self.showHomeVC()
            
        } else {
            
            self.showAlert(title: LocalizationKey.alert_title_error.string, message: msg, actionTitle: LocalizationKey.alert_ok.string)
        }
        
    }
    
    @objc func googleLoginTapped() {
        Common.LogDebug("Google Loggin Tappped")
        GIDSignIn.sharedInstance().signIn()
    }
    

    @objc func receiveToggleAuthUINotification(_ notification: NSNotification) {
      if notification.name.rawValue == "ToggleAuthUINotification" {
        if notification.userInfo != nil {
          guard let userInfo = notification.userInfo as? [String:String] else { return }
            
            if(userInfo["statusText"] != nil) {
                
                Preferences.rememberMe(answer: "yes")
                Preferences.LoginMe(answer: "yes")
                self.showHomeVC()
                
            } else {
                Common.logOutResetValue()
                var msg: String = ""
                if(userInfo["errorText"] != nil) {
                    msg = userInfo["errorText"]!
                } else {
                    msg = LocalizationKey.something_wrong_str.string
                }
                
                self.showAlert(title: LocalizationKey.alert_title_error.string, message: msg, actionTitle: LocalizationKey.alert_ok.string)
                
            }
        }
      }
    }
    
    
    func showHomeVC() {
        
        // move to home screen
        // custom navigation bar color
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = .white
        navigationBarAppearace.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationBarAppearace.barTintColor = kBrandColor
        
        // initialisation of navigation controller and home vc
        let navigationController = UINavigationController()
        let homeVC = HomeViewController()// self.storyboard?.instantiateViewController(withIdentifier: "Mvs_Home_vc")as! HomeViewController
        navigationController.addChild(homeVC)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
    }
    
    
    
    deinit {
      NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "ToggleAuthUINotification"), object: nil)
    }
    

}
