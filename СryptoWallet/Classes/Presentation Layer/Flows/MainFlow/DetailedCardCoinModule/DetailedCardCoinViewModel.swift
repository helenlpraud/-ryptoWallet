//
//  DetailedCardCoinViewModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 08.11.2022.
//

protocol DetailedCardCoinViewModelProtocol {
    
    var name: String { get set }
    var priceUSD: String? { get set }
    var priceBTC: String? { get set }
    var percentChangeUSD24h: String? { get set }
    
    init(coin: CoinTableViewCellModel)
}

final class DetailedCardCoinViewModel: DetailedCardCoinViewModelProtocol {
    
    // MARK: Public Properties
    
    var name: String
    var priceUSD: String?
    var priceBTC: String?
    var percentChangeUSD24h: String?
    
    // MARK: Initializer
    
    required init(coin: CoinTableViewCellModel) {
        self.name = coin.name
        self.priceUSD = coin.priceUSD
        self.priceBTC = coin.priceBTC
        self.percentChangeUSD24h = coin.percentChangeUSD24h
    }
}
