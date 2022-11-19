//
//  CoinseResponse+convertToCoin.swift
//  СryptoWallet
//
//  Created by Shagaeva Elena on 18.11.2022.
//

import Foundation

extension CoinResponse {
    
    func convertToCoin() -> Coin? {
        guard let percentChangeUSD24h = marketData.percentChangeUSD24h else { return nil }
        let coin = Coin(name: name,
                        priceUSD: marketData.priceUSD,
                        priceBTC: marketData.priceBTC,
                        priceETH: marketData.priceETH,
                        percentChangeUSD24h: percentChangeUSD24h)
        return coin
    }
}
