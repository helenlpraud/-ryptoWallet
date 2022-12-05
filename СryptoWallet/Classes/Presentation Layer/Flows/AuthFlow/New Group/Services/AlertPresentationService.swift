//
//  AlertPresentationService.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 01.12.2022.
//

protocol AlertPresentationServiceProtocol {
    
    func showAlert(errorType: ErrorType) -> AlertModel
}

class AlertPresentationService: AlertPresentationServiceProtocol {
    
    func showAlert(errorType: ErrorType) -> AlertModel {
        let action = Action(title: StringsAuth.actionTitle, style: .standart)
        var alertModel = AlertModel(title: "", message: "", actions: [action])
        switch errorType {
        case .invalidLogin:
            alertModel.message = StringsAuth.invalidLogin
        case .invalidPwd:
            alertModel.message = StringsAuth.invalidPwd
        case .invalidData:
            alertModel.message = StringsAuth.invalidInput
        }
        return alertModel
    }
}
