//
//  AuthViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 03.11.2022.
//

enum StateInputAuth {
    case fieldsAreEmpty
    case fieldsAreFilled
    case passwordFieldIsEmpty
    case loginIsEmpty
}

protocol AuthViewModelProtocol {
    
    // MARK: Public Functions
    
    func checkAuthData(currentLogin: String, currentPswd: String) -> ResultCheking
    func auth(result: ResultCheking)
    
    var onFinish: (() -> Void)? { get set }
    var onShowAlertShowed: ((AlertModel) -> Void)? { get set }
    var onFieldsAreFilled: (() -> Void)? { get set }
    var onFieldIsEmpty: ((StateInputForProcessing) -> Void)? { get set }
}

final class AuthViewModel: AuthViewModelProtocol {
    
    // MARK: Public Properties
    
    var authService: AuthServiceProtocol?
    var validationService: ValidationServiceProtocol?
    var processingInputService: ProcessingInputServiceProtocol?
    var alertPresentationService: AlertPresentationServiceProtocol?
    
    var onFinish: (() -> Void)?
    var onShowAlertShowed: ((AlertModel) -> Void)?
    var onFieldsAreFilled: (() -> Void)?
    var onFieldIsEmpty: ((StateInputForProcessing) -> Void)?
    
    // MARK: Public Functions
    
    func getStateInput(login: String,
                       password: String) -> StateInputAuth {
        guard let inputService = processingInputService else { return .fieldsAreEmpty }
        return inputService.getStateInput(login: login, password: password)
    }
    
    func processInput(state: StateInputAuth,
                      login: String,
                      password: String) {
        let resultChecking = checkAuthData(currentLogin: login,
                                           currentPswd: password)
        switch state {
        case .fieldsAreEmpty:
            showAlert(errorType: .invalidInput)
        case .fieldsAreFilled:
            onFieldsAreFilled?()
            auth(result: resultChecking)
        case .passwordFieldIsEmpty:
            onFieldIsEmpty?(.passwordFieldIsEmpty)
        case .loginIsEmpty:
            onFieldIsEmpty?(.loginIsEmpty)
        }
    }
    
    func checkAuthData(currentLogin: String,
                       currentPswd: String) -> ResultCheking {
        return validationService?.checkAuthData(currentLogin: currentLogin, currentPswd: currentPswd)
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
        guard let alertModel = alertPresentationService?.showAlert(errorType: errorType) else { return }
        onShowAlertShowed?(alertModel)
    }
}
