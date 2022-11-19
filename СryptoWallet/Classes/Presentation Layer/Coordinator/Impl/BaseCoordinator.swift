//
//  BaseCoordinator.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import Foundation

class BaseCoordinator: Coordinator {
    
    // MARK: Public Properties

    var childCoordinators: [Coordinator] = []

    let router: Routable
    
    // MARK: Initializer

    init(router: Routable) {
        self.router = router
    }
    
    // MARK: Public Functions

    open func start() { }

    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator })
            else { return }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        guard let indexToRemove = childCoordinators.firstIndex(where: { $0 === coordinator })
            else { return }
        childCoordinators.remove(at: indexToRemove)
    }

    func removeAllDependencies() {
        childCoordinators.removeAll()
    }
}
