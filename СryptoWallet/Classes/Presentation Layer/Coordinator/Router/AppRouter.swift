//
//  Router.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 16.11.2022.
//

import UIKit

final class AppRouter: Routable {

    // MARK: Public Properties

    var toPresent: UIViewController? {
        return rootController
    }
    
    // MARK: Private Properties

    private var rootController: UIViewController? {
        get {
            return window?.rootViewController
        } set {
            window?.rootViewController = newValue
        }
    }
    
    private weak var window: UIWindow?
    
    // MARK: Initializer

    init(window: UIWindow?) {
        self.window = window
    }
    
    // MARK: Public Functions

    func setRootModule(_ module: Presentable?, animated: Bool) {
        guard let toController = module?.toPresent else { return }
        rootController = toController
    }

    func present(_ module: Presentable?, animated: Bool) {
        guard let controllerToPresent = module?.toPresent else { return }
        rootController?.present(controllerToPresent, animated: animated, completion: nil)
    }

    func dismissModule(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: nil)
    }

    func push(_ module: Presentable?, animated: Bool) {
        guard let controllerToPush = module?.toPresent else { return }
        (rootController as? UINavigationController)?.pushViewController(controllerToPush, animated: animated)
    }

    func popModule(animated: Bool) {
        (rootController as? UINavigationController)?.popViewController(animated: animated)
    }
}
