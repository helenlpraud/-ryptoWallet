//
//  NavigationRouter.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 16.11.2022.
//

import UIKit

struct NavigationRouter: Routable {
    
    // MARK: Private Properties

    private let rootController: UINavigationController
    
    // MARK: Public Properties
    
    var toPresent: UIViewController? {
        return rootController
    }
    
    // MARK: Initializer

    init(rootController: UINavigationController) {
        self.rootController = rootController
    }
    
    // MARK: Public Functions

    func present(_ module: Presentable?, animated: Bool) {
        guard let controllerToPresent = module?.toPresent else { return }
        rootController.present(controllerToPresent, animated: animated, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController.dismiss(animated: animated, completion: completion)
    }

    func push(_ module: Presentable?, animated: Bool) {
        guard let controllerToPush = module?.toPresent else { return }
        if let topController = rootController.topViewController,
            type(of: controllerToPush) == type(of: topController) { return }
        rootController.pushViewController(controllerToPush, animated: animated)
    }

    func popModule(animated: Bool) {
        rootController.popViewController(animated: animated)
    }

    func setRootModule(_ module: Presentable?, animated: Bool) {
        guard let controllerToSet = module?.toPresent else { return }
        rootController.setViewControllers([controllerToSet], animated: animated)
    }
}
