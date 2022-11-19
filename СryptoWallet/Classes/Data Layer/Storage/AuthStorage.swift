//
//  AuthStorage.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import Foundation

protocol AuthStorageProtocol {
    
    // MARK: Public Funcions

    func saveAuth(_ newValue: Bool)
    func obtainAuth() -> Bool
}

final class AuthStorage: AuthStorageProtocol {
    
    // MARK: Constants
    
    struct Constants {

        static let authenticatedKey = "authenticated"
    }
    
    // MARK: Private Properties
    
    private var auth: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Constants.authenticatedKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Constants.authenticatedKey)
        }
    }
    
    // MARK: Public Funcions

    func saveAuth(_ newValue: Bool) {
        auth = newValue
    }

    func obtainAuth() -> Bool {
        return auth
    }
}
