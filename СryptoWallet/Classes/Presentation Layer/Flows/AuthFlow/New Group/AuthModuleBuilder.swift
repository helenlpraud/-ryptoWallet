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
        let viewModel = AuthViewModel()
        let authServise = AuthService()
        let validationService = ValidationService()
        let alertPresentationService = AlertPresentationService()
        let processingInputService = ProcessingInputService()
        authServise.storage = AuthStorage()
        viewModel.authService = authServise
        viewModel.validationService = validationService
        viewModel.processingInputService = processingInputService
        viewModel.alertPresentationService = alertPresentationService
        controller.viewModel = viewModel
        return controller
    }
}
