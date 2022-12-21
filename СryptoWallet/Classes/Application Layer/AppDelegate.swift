//
//  AppDelegate.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 02.11.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private lazy var appCoordinator: Coordinator = createCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        appCoordinator.start()
        window?.makeKeyAndVisible()
        return true
    }
    
    private func createCoordinator() -> Coordinator {
        let router = AppRouter(window: window)
        let coordinator = AppCoordinator(router: router)
        let authServise = AuthService()
        authServise.storage = AuthStorage()
        coordinator.authStateProvider = authServise
        return coordinator
    }
}

