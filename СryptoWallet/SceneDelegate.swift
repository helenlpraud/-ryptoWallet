//
//  SceneDelegate.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 02.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let requests = [CoinRequest(typeCoin: .btc),
                        CoinRequest(typeCoin: .cardano),
                        CoinRequest(typeCoin: .dogecoin)]
        let coinsListModel = CoinsListViewModel(requests: requests)
        let navController = UINavigationController(rootViewController: CoinsListViewController(with: coinsListModel))
        window?.rootViewController = navController
//        window?.rootViewController = DetailedCardCoinViewController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }
}

