//
//  AuthService.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

protocol AuthStateProvider {

    var authState: Bool { get }
}

protocol AuthServiceProtocol {

    func auth()
    func logout()
}

final class AuthService: AuthServiceProtocol,
                         AuthStateProvider {

    var storage: AuthStorage?

    func auth() {
        storage?.saveAuth(true)
    }

    func logout() {
        storage?.saveAuth(false)
    }
    
    var authState: Bool {
        guard let storage = storage else { return false }
        return storage.obtainAuth()
    }
}
