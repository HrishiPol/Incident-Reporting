//
//  LoginViewModel.swift
//  Incident Reporting
//
//  Created by Hrishikesh Pol on 17/6/20.
//  Copyright © 2020 Hrishikesh Pol. All rights reserved.
//

import Foundation

/// Enum for login status.
enum LoginStatus {
    case success
    case invalidUsernameLenght
    case invalidUsernameCharacters
    case invalidPasswordLenght
}

typealias UserLoginCompletionClosure = (_ status: LoginStatus,_ error: String ) -> Void

/// Viewmodel for login module.
class LoginViewModel {
    /// User entity.
    private let userDataModel: User
    
    /// Init method
    /// - Parameter userDataModel: User entity.
    init(_ userDataModel: User) {
        self.userDataModel = userDataModel
    }
    
    /// Method to validate user and perform login activity.
    /// - Parameter completionHanlder: Handler call on login action.
    func login(completionHanlder: @escaping UserLoginCompletionClosure) {

        let decimalCharacters = CharacterSet.decimalDigits
        if self.userDataModel.username.count < 8 {
            completionHanlder(LoginStatus.invalidUsernameLenght,
                              Constant.kUsernameLenghtError.rawValue)
        } else if self.userDataModel.username.rangeOfCharacter(from: decimalCharacters) != nil {
            completionHanlder(LoginStatus.invalidUsernameCharacters,
                              Constant.kUsernameAlphabeticError.rawValue)
        } else if self.userDataModel.password.count < 8 {
            completionHanlder(LoginStatus.invalidPasswordLenght,
                              Constant.kPasswordLenghtError.rawValue)
        } else {
            completionHanlder(LoginStatus.success, "")
        }
    }

}
