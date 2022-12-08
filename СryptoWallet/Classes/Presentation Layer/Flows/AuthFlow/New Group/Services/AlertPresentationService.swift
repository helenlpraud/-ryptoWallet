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
        case .invalidInput:
            alertModel.message = StringsAuth.invalidInput
        }
        return alertModel
    }
}

struct AlertModel: Equatable {
    
    static func == (lhs: AlertModel, rhs: AlertModel) -> Bool {
        lhs.title == rhs.title &&
        lhs.message == rhs.message &&
        lhs.actions == rhs.actions
    }
    
    var title: String
    var message: String
    var actions: [Action]
}

struct Action: Equatable {
    let title: String
    let style: AlertActionsStyle
}

enum AlertActionsStyle {
    case standart
}
