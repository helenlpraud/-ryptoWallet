//
//  DetailedCardCoinModuleBuilder.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 15.11.2022.
//

import UIKit

final class DetailedCardCoinModuleBuilder {
    
    static func createDetailedCardCoinModule(coin: CoinTableViewCellModel) -> UIViewController {
        let controller = DetailedCardCoinViewController()
        let viewModel = DetailedCardCoinViewModel(coin: coin)
        controller.viewModel = viewModel
        return controller
    }
}
