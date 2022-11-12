//
//  AuthViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 03.11.2022.
//

import UIKit

protocol AuthViewModelProtocol {
    
    // MARK: Public Functions
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> Bool
    func auth(isSuccessChecked: Bool)
}

class AuthViewModel: AuthViewModelProtocol {
    
    // MARK: Public Functions
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> Bool {
        if (currentLogin == ValidationConstants.login &&
            currentPswd == ValidationConstants.password) {
            return true
        } else {
            return false
        }
    }
    
    func auth(isSuccessChecked: Bool) {
        if isSuccessChecked {
            print("Auth success")
        } else {
            print("Auth failed")
        }
    }
}
