//
//  ProcessingInputService.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 01.12.2022.
//

import Foundation

protocol ProcessingInputServiceProtocol {
    
    func getStateInput(login: String, password: String) -> StateInputAuth
}

final class ProcessingInputService: ProcessingInputServiceProtocol {
    
    func getStateInput(login: String, password: String) -> StateInputAuth {
        if !login.isEmpty && !password.isEmpty {
            return .fieldsAreFilled
        } else if (!login.isEmpty && password.isEmpty) {
            return .passwordFieldIsEmpty
        } else if (login.isEmpty && !password.isEmpty) {
            return .loginIsEmpty
        } else {
            return .fieldsAreEmpty
        }
    }
}
