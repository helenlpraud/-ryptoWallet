//
//  AuthViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 03.11.2022.
//

import UIKit

protocol AuthViewModelProtocol {
    
    // MARK: Public Functions
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> ResultCheking
    func auth(result: ResultCheking)
    func keyboardWillShow(notification: NSNotification)
    func keyboardWillHide(notification: NSNotification)
    
    var onFinish: (() -> Void)? { get set }
    var onShowAlertShowed: ((AlertModel) -> Void)? { get set }
    var onKeyboardWillShow: ((CGFloat) -> Void)? { get set }
    var onKeyboardWillHide: (() -> Void)? { get set }
}

final class AuthViewModel: AuthViewModelProtocol {
    
    // MARK: Public Properties
    
    var authService: AuthServiceProtocol?
    var validationService: ValidationServiceProtocol

    var onFinish: (() -> Void)?
    var onShowAlertShowed: ((AlertModel) -> Void)?
    var onKeyboardWillShow: ((CGFloat) -> Void)?
    var onKeyboardWillHide: (() -> Void)?
    
    // MARK: Initializer
    
    init(validationService: ValidationServiceProtocol) {
        self.validationService = validationService
    }
    
    // MARK: Public Functions
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> ResultCheking {
        return validationService.checkAuthData(currentLogin: currentLogin, currentPswd: currentPswd)
    }
    
    func auth(result: ResultCheking) {
        if result?.isSuccessChecked == true {
            authService?.auth()
            onFinish?()
        } else {
            guard let errorType = result?.errorType else { return }
            showAlert(errorType: errorType)
        }
    }
    
    private func showAlert(errorType: ErrorType) {
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
        onShowAlertShowed?(alertModel)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let height = keyboardSize.height
            onKeyboardWillShow?(height)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        onKeyboardWillHide?()
    }
}

struct AlertModel {
    let title: String
    var message: String
    let actions: [Action]
}

struct Action {
    let title: String
    let style: AlertActionsStyle
}

enum AlertActionsStyle {
    case standart
}
