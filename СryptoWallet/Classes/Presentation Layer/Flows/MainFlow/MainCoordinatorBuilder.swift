//
//  MainCoordinatorBuilder.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 16.11.2022.
//

import UIKit

final class MainCoordinatorBuilder {
    
    static func createMainCoordinator() -> MainCoordinatorProtocol {
        let navigationController = UINavigationController()
        let router = NavigationRouter(rootController: navigationController)
        let coordinator = MainCoordinator(router: router)
        return coordinator
    }
}
