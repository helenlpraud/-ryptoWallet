//
//  CoinsResponse+CreateCell.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 18.11.2022.
//

import Foundation

extension CoinResponse {
    
    func createCellModel() -> CoinTableViewCellModel {
        let cellModel = CoinTableViewCellModel(name: name,
                                               priceUSD: nil,
                                               priceBTC: nil,
                                               percentChangeUSD24h: nil)
        if let priceUSD = marketData.priceUSD?.rounded(toPlaces: 3) {
            cellModel.priceUSD = String(priceUSD)
        }
        if let priceBTC = marketData.priceUSD?.rounded(toPlaces: 3) {
            cellModel.priceBTC = String(priceBTC)
        }
        if let percentChangeUSD24h = marketData.percentChangeUSD24h?.rounded(toPlaces: 3) {
            cellModel.percentChangeUSD24h = String(percentChangeUSD24h)
        }
        return cellModel
    }
}
