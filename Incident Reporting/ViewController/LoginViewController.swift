//
//  LoginViewController.swift
//  Incident Reporting
//
//  Created by Hrishikesh Pol on 18/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import UIKit
import MaterialComponents

/// Login view controlller.
class LoginViewController: UIViewController {
    
    /// Username textfield.
    @IBOutlet weak var usernameTextField: MDCFilledTextField!
    
    /// Login button.
    @IBOutlet weak var loginButton: MDCButton!
    
    /// Password textfield.
    @IBOutlet weak var passwordTextField: MDCFilledTextField!
    
    /// Login view model.
    var loginViewModel: LoginViewModel?
    
    /// Login completion clousure.
    var loginCompletionClosure: UserLoginCompletionClosure?
    
    /// View life cycle.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        /// Tap gesture to dismiss keyboard.
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)

        // Action on login status.
        loginCompletionClosure = { [unowned self] ( status: LoginStatus, error: String ) -> Void in
            switch status {
            case .success:
                self.navigateToHomeScreen()
            case .invalidPasswordLenght:
                self.showError(error: error)
            case .invalidUsernameCharacters:
                self.showError(error: error)
            case .invalidUsernameLenght:
                self.showError(error: error)
            }
        }
    }
    
    /// Fuction to dismiss keyboard.
    @objc private func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    /// Function to show error.
    /// - Parameter error: Error message.
    private func showError(error: String) {
        let alertController = UIAlertController(title: Constant.kErrorTitle.rawValue,
                                                message: error,
                                                preferredStyle:UIAlertController.Style.alert)

        alertController.addAction(UIAlertAction(title: Constant.kAlertButtonTitle.rawValue,
                                                style: UIAlertAction.Style.default) { action -> Void in
        })
        self.present(alertController, animated: true, completion: nil)

    }
    
    /// Function to load home screen.
    private func navigateToHomeScreen() {
        let storyboard = UIStoryboard(name: Constant.kMainStoryBoard.rawValue, bundle: nil)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: Constant.kHomeViewController.rawValue)
        let navigationController = UINavigationController.init(rootViewController: homeViewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: false, completion: nil)
    }
    
    /// Action perform on login button touch up inside.
    /// - Parameter sender: Login button.
    @IBAction func loginButtonPressed(_ sender: Any) {
        if let username = usernameTextField.text,
            let password = passwordTextField.text,
            let handler = loginCompletionClosure {
            self.loginViewModel = LoginViewModel.init(User.init(username: username, password: password))
            self.loginViewModel?.login(completionHanlder: handler)
        } else {
            showError(error: Constant.kCommonError.rawValue)
        }

    }
}
