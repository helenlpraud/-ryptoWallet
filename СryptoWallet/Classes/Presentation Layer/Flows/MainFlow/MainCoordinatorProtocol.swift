//
//  MainCoordinator.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

protocol MainCoordinatorProtocol: Coordinator {

    var onLogout: (() -> Void)? { get set }
}

final class MainCoordinator: BaseCoordinator, MainCoordinatorProtocol {
    
    // MARK: Public properties

    var onLogout: (() -> Void)?
    
    // MARK: Public functions

    override func start() {
        showCoinsList()
    }
    
    // MARK: Private functions

    private func showCoinsList() {
        var module = CoinsListModuleBuilder.createCoinsListModule()
        module.onCoinSelect = showDetails
        module.onLogout = onLogout
        router.push(module, animated: false)
    }

    private func showDetails(for coin: CoinTableViewCellModel) {
        let module = DetailedCardCoinModuleBuilder.createDetailedCardCoinModule(coin: coin)
        router.push(module)
    }
}
