//
//  AppCoordinator.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import Foundation

protocol AppCoordinatorProtocol: Coordinator { }

final class AppCoordinator: BaseCoordinator, AppCoordinatorProtocol {
    
    // MARK: Public Properties
    
    var authStateProvider: AuthStateProvider?
    
    // MARK: Public Functions
    
    override func start() {
        guard let authStateProvider = authStateProvider else { return }
        switch authStateProvider.authState {
        case false:
            runAuthFlow()
        case true:
            runMainFlow()
        }
    }
    
    // MARK: Private Functions
    
    private func runAuthFlow() {
        let coordinator = AuthCoordinatorBuilder.createAuthCoordinator()
        coordinator.onFinish = { [weak coordinator, weak self] in
            self?.removeDependency(coordinator)
            self?.runMainFlow()
        }
        addDependency(coordinator)
        router.setRootModule(coordinator.router)
        coordinator.start()
    }
    
    private func runMainFlow() {
        let coordinator = MainCoordinatorBuilder.createMainCoordinator()
        coordinator.onLogout = { [weak coordinator, weak self] in
            self?.removeDependency(coordinator)
            self?.runAuthFlow()
        }
        addDependency(coordinator)
        router.setRootModule(coordinator.router)
        coordinator.start()
    }
}
