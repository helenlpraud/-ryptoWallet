//
//  Coin+convertToCellModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 18.11.2022.
//

import Foundation

extension Coin {
    
    func convertToCellModel() -> CoinTableViewCellModel {
        let priceUSD = priceUSD?.rounded(toPlaces: 3).toString()
        let priceBTC = priceBTC?.rounded(toPlaces: 3).toString()
        let percentChangeUSD24h = percentChangeUSD24h.toString()
        let cellModel = CoinTableViewCellModel(name: name,
                                               priceUSD: priceUSD,
                                               priceBTC: priceBTC,
                                               percentChangeUSD24h: percentChangeUSD24h)
        return cellModel
    }
}
