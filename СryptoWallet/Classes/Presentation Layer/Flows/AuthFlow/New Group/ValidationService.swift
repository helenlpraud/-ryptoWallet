//
//  ValidationService.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import Foundation

protocol ValidationServiceProtocol {
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> Bool
}

final class ValidationService: ValidationServiceProtocol {
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> Bool {
        if (currentLogin == ValidationConstants.login &&
            currentPswd == ValidationConstants.password) {
            return true
        } else {
            return false
        }
    }
}


