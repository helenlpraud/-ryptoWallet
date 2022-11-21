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
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> Bool {
        validationService.checkAuthData(currentLogin: currentLogin, currentPswd: currentPswd)
    }
    
    func auth(isSuccessChecked: Bool) {
        if isSuccessChecked {
            authService?.auth()
            onFinish?()
        } else {
            showAlert()
        }
    }
    
    func showAlert() {
        let action = Action(title: "OK", style: .standart)
        let alertModel = AlertModel(title: "Incorrect input", message: "Incorrect login or password, please repeat again", actions: [action])
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
    let message: String
    let actions: [Action]
}

struct Action {
    let title: String
    let style: AlertActionsStyle
}

enum AlertActionsStyle {
    case standart
}
