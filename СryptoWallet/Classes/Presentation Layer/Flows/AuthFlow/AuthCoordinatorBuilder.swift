//
//  AuthCoordinatorBuilder.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 16.11.2022.
//

import UIKit

final class AuthCoordinatorBuilder {
    
    static func createAuthCoordinator() -> AuthCoordinatorProtocol {
        let navigationController = UINavigationController()
        let router = NavigationRouter(rootController: navigationController)
        let coordinator = AuthCoordinator(router: router)
        return coordinator
    }
}
