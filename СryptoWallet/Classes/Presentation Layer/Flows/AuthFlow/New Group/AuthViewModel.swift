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
    
    var onFinish: (() -> Void)? { get set }
}

final class AuthViewModel: AuthViewModelProtocol {
    
    // MARK: Public Properties
    
    var authService: AuthServiceProtocol?
    var validationService: ValidationServiceProtocol
    
    var onFinish: (() -> Void)?
    
    // MARK: Initializer
    
    init(validationService: ValidationServiceProtocol) {
        self.validationService = validationService
    }
    
    // MARK: Public Functions
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> Bool {
        validationService.checkAuthData(currentLogin: currentLogin, currentPswd: currentPswd)
    }
    
    func auth(isSuccessChecked: Bool) {
        if isSuccessChecked {
            authService?.auth()
            onFinish?()
        } else {
            print("Auth failed")
        }
    }
}
