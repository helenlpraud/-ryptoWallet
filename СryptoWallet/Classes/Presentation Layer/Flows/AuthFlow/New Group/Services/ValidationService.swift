//
//  ValidationService.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import Foundation
import UIKit

typealias ResultCheking = (isSuccessChecked: Bool, errorType: ErrorType?)?

enum ErrorType {
    case invalidLogin
    case invalidPwd
    case invalidInput
}

protocol ValidationServiceProtocol {
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> ResultCheking
}

final class ValidationService: ValidationServiceProtocol {
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> ResultCheking {
        if (currentLogin == ValidationConstants.login &&
            currentPswd == ValidationConstants.password) {
            return (true, nil)
        } else if (currentLogin == ValidationConstants.login &&
                   currentPswd != ValidationConstants.password) {
            return (false, .invalidPwd)
        } else if (currentLogin != ValidationConstants.login &&
                   currentPswd == ValidationConstants.password)  {
            return (false, .invalidLogin)
        } else {
            return (false, .invalidInput)
        }
    }
}


