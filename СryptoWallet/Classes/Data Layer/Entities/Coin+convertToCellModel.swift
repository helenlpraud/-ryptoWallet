//
//  Coin+convertToCellModel.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 18.11.2022.
//

import Foundation

extension Coin {
    
    func convertToCellModel() -> CoinTableViewCellModel {
        let cellModel = CoinTableViewCellModel(name: name,
                                               priceUSD: nil,
                                               priceBTC: nil,
                                               percentChangeUSD24h: nil)
        if let priceUSD = priceUSD?.rounded(toPlaces: 3) {
            cellModel.priceUSD = priceUSD.toString()
        }
        if let priceBTC = priceUSD?.rounded(toPlaces: 3) {
            cellModel.priceBTC = priceBTC.toString()
        }
        cellModel.percentChangeUSD24h = percentChangeUSD24h.toString()
        return cellModel
    }
}
