//
//  AuthModuleBuilder.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import UIKit

final class AuthModuleBuilder {
    
    static func createAuthModule() -> AuthModule {
        let controller = AuthViewController()
        let validationService = ValidationService()
        let viewModel = AuthViewModel(validationService: validationService)
        let authServise = AuthService()
        authServise.storage = AuthStorage()
        viewModel.authService = authServise
        controller.viewModel = viewModel
        return controller
    }
}
