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
        if let priceUSD = marketData.priceUSD {
            cellModel.priceUSD = String(priceUSD)
        }
        if let priceBTC = marketData.priceUSD {
            cellModel.priceBTC = String(priceBTC)
        }
        if let percentChangeUSD24h = marketData.percentChangeUSD24h {
            cellModel.percentChangeUSD24h = String(percentChangeUSD24h)
        }
        return cellModel
    }
}
