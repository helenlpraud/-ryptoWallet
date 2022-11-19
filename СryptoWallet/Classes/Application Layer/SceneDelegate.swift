//
//  SceneDelegate.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 02.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private lazy var appCoordinator: Coordinator = makeAppCoordinator()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        appCoordinator.start()
//        let rootViewController = CoinsListModuleBuilder.createCoinsListModule()
//        let navController = UINavigationController(rootViewController: rootViewController)
//        window?.rootViewController = navController
////        window?.rootViewController = DetailedCardCoinViewController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}

extension SceneDelegate {
    
    func makeAppCoordinator() -> Coordinator {
        let router = AppRouter(window: window)
        let coordinator = AppCoordinator(router: router)
        let authServise = AuthService()
        authServise.storage = AuthStorage()
        coordinator.authStateProvider = authServise
        return coordinator
    }
}
