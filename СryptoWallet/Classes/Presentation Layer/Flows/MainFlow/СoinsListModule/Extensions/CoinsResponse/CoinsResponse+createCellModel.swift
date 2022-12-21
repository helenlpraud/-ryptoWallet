//
//  CoinsResponse+CreateCell.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 18.11.2022.
//

import Foundation

extension CoinResponse {
    
    func createCellModel() -> CoinTableViewCellModel {
        let priceUSD = marketData.priceUSD?.rounded(toPlaces: 3).toString()
        let priceBTC = marketData.priceBTC?.rounded(toPlaces: 3).toString()
        let percentChangeUSD24h = marketData.percentChangeUSD24h?.rounded(toPlaces: 3).toString()
        let cellModel = CoinTableViewCellModel(name: name,
                                               priceUSD: priceUSD,
                                               priceBTC: priceBTC,
                                               percentChangeUSD24h: percentChangeUSD24h)
        return cellModel
    }
}
