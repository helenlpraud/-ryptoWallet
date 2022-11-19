//
//  AuthCoordinator.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 16.11.2022.
//

protocol AuthCoordinatorProtocol: Coordinator {

    var onFinish: (() -> Void)? { get set }
}

final class AuthCoordinator: BaseCoordinator, AuthCoordinatorProtocol {

    var onFinish: (() -> Void)?

    override func start() {
        showAuthModule()
    }

    func showAuthModule() {
        var module = AuthModuleBuilder.createAuthModule()
        module.onFinish = { [weak self] in
            self?.onFinish?()
        }
        router.push(module)
    }
}
